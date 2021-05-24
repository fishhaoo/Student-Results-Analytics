data edudata;
	infile "/home/u47555010/edu-data-2019-5 (EDITED).csv" dlm=',' firstobs=2;
	input Gender Subject MidTermTest Login DiscussionMarks OnTimeSubmission AbsenceDays FinalExamMarks FinalExamPass;
run;

/** backward selection method **/
proc reg data=edudata;
	model FinalExamMarks = MidTermTest Login DiscussionMarks OnTimeSubmission AbsenceDays / selection=backward;
	title 'Edu data: using backward selection';
run;

/** mallow cp **/
ods graphics / imagemap=on;
proc reg data=edudata plots(only)=cp(label);
	model FinalExamMarks = Gender Subject MidTermTest Login DiscussionMarks OnTimeSubmission AbsenceDays / selection=cp best=20;
	title 'Edu data: best 20 models';
run;
ods graphics off;

/** descriptive analysis   **/
PROC UNIVARIATE DATA=edudata;
  VAR FinalExamMarks;
  histogram FinalExamMarks / normal;
  inset mean mode median;
RUN; 
