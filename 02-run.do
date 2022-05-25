*Do-file to run COVID-19 RRPS Household cleaning and analysis.

*Check if filepaths have been established using 01-init.do
if "${gsdProcessed}"=="" {
	display as error "Please run 01-init.do first."
	error 1
}

*** Round 1 
***1-stage 
/*Import and Prepare the raw data for quality checks and run them
run "${gsdDo}/1-1-check_r1.do"

*Process raw dataset
run "${gsdDo}/1-2-process_r1.do"

*Creation of weights
run "${gsdDo}/1-3-weights_r1.do"

*Creation of household and household member level datasets
run "${gsdDo}/1-4-create_datasets_r1.do"

*Creation of micro-data files
run "${gsdDo}/1-5-micro-data_r1.do"

********************************************************************************
***2-stage
********************************************************************************

* Prepare indicators for policy note 
run "${gsdDo}/2-1-policy_note_prep.do"

*SWIFT poverty imputation for hh dataset
run "${gsdDo}/2-2-0-mi_swift_prepare.do"
run "${gsdDo}/2-2-1-mi_swift_cv.do"

********************************************************************************
*** 3-stage
*Generate report for analysis 
run "${gsdDo}/3-1-tableau.do"

dis "*****Analysis for Round 1 completed successfully!*****" */
