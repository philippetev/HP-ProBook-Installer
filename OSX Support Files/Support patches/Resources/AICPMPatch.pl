#!/usr/bin/perl
# by el coniglio
#
# modified by RehabMan to work with more versions of otool
# (some versions of otool are writing disassembled code using
#  decimal instead of hex)

$file = $ARGV[0];
$patch = 0;
if($ARGV[1] and $ARGV[1] eq "--patch") {
	$patch = 1;
}
if(!$file) {
	die "Usage: perl $0 <file> [--patch]\n";	
}
my %arch;
my %off;
my %addr;

open(PIPE, "./lipo -detailed_info $file|");
while(<PIPE>) {
	chomp;
	$line = $_;
	if($line =~ /^architecture (.*)$/) {
		$carch = $1;
	} elsif($line =~ /offset (\d+)$/) {
		$arch{$carch} = $1;
	} elsif($line =~ /^Non-fat .* architecture: (.*)$/) {
		$carch = $1;
		$arch{$carch} = 0;
	}
}
close(PIPE);

print "\n$file\n";

foreach $ar (keys %arch) {
	my @enderecos = ();
	
	print "\narch: ".$ar."\n\n";
	
	open(PIPE, "./otool -l -arch $ar $file|");
	$segname = "";
	while(<PIPE>) {
		chomp;
		$line = $_;
		if($line =~ /sectname (.*)$/) {
			$segname = $1;
		} elsif($segname eq "__text" and $line =~ /addr 0x(.*)$/) {
			$addr{$ar} = hex($1);
		} elsif($segname eq "__text" and $line =~ /offset (\d+)$/) {
			$off{$ar} = $1;
		}
	}
	close(PIPE);
	
	open(PIPE, "./otool -tV -arch $ar $file|");
	$flag = 0;
	while(<PIPE>) {
		$line = $_;
		if($line =~ /mov[lw]\t\$0x([0-9A-Fa-f]+),\s*\%e?cx/) {
			$value = hex($1);
			if($value == 0xe2) {
				$flag = 1;
			} else {
				$flag = 0;
			}
		}
        # rehabman: added ecx to be set with decimal (226)
		if($line =~ /mov[lw]\t\$([0-9]+),\s*\%e?cx/) {
			if($1 == 0xe2) {
				$flag = 1;
			} else {
				$flag = 0;
			}
		}
		if($flag == 1 and $line =~ /^(.*)\twrmsr/) {
			$tmp = hex($1) + $arch{$ar} + $off{$ar} - $addr{$ar};
			push(@enderecos, $tmp);
			$flag = 0;
		}
	}
	close(PIPE);

	open(FILE, "+<".$file) or die "$file: $!\n";
	binmode FILE;
	foreach $offset (@enderecos) {
		seek FILE, $offset, 0;
		$ret = read FILE, $data, 2;
		($char1, $char2) = split(//, $data);
		if(ord($char1) == 15 and ord($char2) == 48) {
			if($patch) {
				seek FILE, $offset, 0;
				print FILE chr(144).chr(144);
			}
			printf("found wrmsr at %x".($patch?", patched\n":"\n"), $offset);
		} else {
			printf("ignored %x (%02x %02x)\n", $offset, ord($char1), ord($char2));
		}
	}
	close(FILE);
}
