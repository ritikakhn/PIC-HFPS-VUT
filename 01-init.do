* ------------------------------------------------------------------
*                         
*-------------------------------------------------------------------

clear all
set more off
set maxvar 120000
set seed 10051990 

* Define username
global suser = c(username)

*Initialize directories as follows:
*For swdLocal, update address of your local directory. 
*For swdBox, update address of your Teams OneDrive directory. 

*Utz (File paths need to be updated)
if (inlist("${suser}","wb390290","WB390290")) {
	local swdLocal = "C:\Users\wb390290\OneDrive - WBG\Home\Code\PIC-HFPS-TON"
	local swdBox = "C:\Users\wb390290\WBG\Pacific Observatory - WB Group - Documents\HFPS\C-Tonga"
} 

*Ritika
else if (inlist("${suser}","wb570683", "WB570683")) {
	local swdLocal = "C:\Users\wb570683\OneDrive - WBG\Countries\Tonga\HFPS"
	local swdBox =  "C:\Users\wb570683\WBG\Pacific Observatory - WB Group - Documents\HFPS\C-Tonga"
}

*Shohei (File paths need to be updated)
else if (inlist("${suser}","wbxxxxxx", "WBxxxxxx")) {
	local swdLocal = "C:\Users\wbxxxxxx\OneDrive - WBG\Countries\Tonga\HFPS"
	local swdBox =  "C:\Users\wbxxxxxx\WBG\Pacific Observatory - WB Group - Documents\HFPS\C-Tonga"
}

else {
	di as error "Configure work environment in 01-init.do before running the code."
	error 1
}

* Define filepaths
global gsdDataRaw = "`swdBox'/Data-Raw"
global gsdProcessed = "`swdLocal'/1-Processed"
global gsdPublished = "`swdLocal'/1-Processed/Published"
global gsdNonPublished = "`swdLocal'/1-Processed/Non-Published"
global gsdCleaned = "`swdLocal'/2-Cleaned"
global gsdOutput = "`swdLocal'/3-Output"
global gsdDo = "`swdLocal'/Do"
global gsdTemp = "`swdLocal'/Temp"

*If needed, install the necessary commands and packages 
qui capture which ipacheck
qui if _rc!=0 {
	noisily di "This command requires ipacheck. The package will now be downloaded and installed."
	net install ipacheck, from("https://raw.githubusercontent.com/PovertyAction/high-frequency-checks/master/ado") replace
}

local commands = "tabout confirmdir"
foreach c of local commands {
	qui capture which `c' 
	qui if _rc!=0 {
		noisily di "This command requires '`c''. The package will now be downloaded and installed."
		ssc install `c'
	}
}

*If needed, install the directories, and sub-directories used in the process 
foreach i in "$gsdProcessed" "$gsdPublished" "$gsdNonPublished" "$gsdCleaned" "$gsdOutput" "$gsdTemp" {
	confirmdir "`i'" 
	if _rc!=0 {
		mkdir "`i'" 
	}
	else {
		qui display "No action needed"		
	}
}
