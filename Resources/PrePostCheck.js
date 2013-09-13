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
		|| choices.installer_choice_10.selected 
		|| choices.installer_choice_11.selected 
		|| choices.installer_choice_12.selected);
	return (tSelect); 
}
	
function CommonSelected()
{
	var tSelect;
	tSelect=(choices.installer_choice_2_2_1.selected 
		|| choices.installer_choice_2_2_2.selected 
		|| choices.installer_choice_2_2_3.selected 
		|| choices.installer_choice_2_2_4.selected 
		|| choices.installer_choice_2_2_5.selected 
		|| choices.installer_choice_2_3_1.selected 
		|| choices.installer_choice_2_3_2.selected 
		|| choices.installer_choice_2_3_3.selected);
	return (tSelect); 
}
