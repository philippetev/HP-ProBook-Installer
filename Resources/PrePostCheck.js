function PrePostSelected()
{
	var tSelect;
	tSelect=(choices.installer_choice_2.selected 
		|| choices.installer_choice_3.selected 
		|| choices.installer_choice_4.selected 
		|| choices.installer_choice_5.selected 
		|| choices.installer_choice_6.selected 
		|| choices.installer_choice_7.selected 
		|| choices.installer_choice_8.selected 
		|| choices.installer_choice_9.selected 
		|| choices.installer_choice_10.selected);
	return (tSelect); 
}

function CommonSelected()
{
	var tSelect;
	tSelect=choices.installer_choice_2.selected;
	return (tSelect);
}

function DSDTSelected()
{
	var tSelect;
	tSelect=(choices.installer_choice_4_1.selected 
		&amp;&amp; choices.installer_choice_4_2.selected 
		&amp;&amp; choices.installer_choice_4_3.selected);
	return (tSelect);
}
