function PrePostSelected()
{
	return (choices.installer_choice_2.selected 
		|| choices.installer_choice_3.selected 
		|| choices.installer_choice_4.selected 
		|| choices.installer_choice_5.selected 
		|| choices.installer_choice_6.selected 
		|| choices.installer_choice_7.selected 
		|| choices.installer_choice_8.selected 
		|| choices.installer_choice_9.selected 
		|| choices.installer_choice_10.selected);
}

function CommonSelected()
{
	return (choices.installer_choice_2.selected);
}

function DSDTSelected()
{
	return (choices.installer_choice_4_1.selected 
		|| choices.installer_choice_4_2.selected 
		|| choices.installer_choice_4_3.selected
		|| choices.installer_choice_4_4.selected);
}

function SysDefSelected()
{
	return (choices.installer_choice_6_1.selected 
		|| choices.installer_choice_6_2.selected 
		|| choices.installer_choice_6_3.selected 
		|| choices.installer_choice_6_4.selected 
		|| choices.installer_choice_6_5.selected 
		|| choices.installer_choice_6_6.selected);
}