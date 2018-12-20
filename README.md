# web-translations

Updating language files in the Monsenso/web repository
======================================================

Language files in the Monsenso/web repository:

Project         | Platform id       | Example of file
----------------|-------------------|-----------------
 Web Portal     | portal            | web_src_portal_patient_overview_i18n-en-GB
 Patient App    | device            | web_src_device_selfassessment_i18n-en-GB
 Carer App      | caregiver         | web_src_caregiver_associations_i18n-en-GB
 Signup         | signup            | web_src_signup_app_i18n-en-GB


<br><br>
**Extracting language files**

Run the Ruby script translate.rb:
````shell
ruby translate.rb
````
You will see the following instructions in the terminal:

````shell
Select task:

1. Extract language files
2. Insert language files
0. Quit
````

Select 1 to extract langauge files.

When the script has terminated, the en-GB language files will be in the folder Language.


<br><br>
**Updating/inserting language files**

Language files are delivered with en-GB.json as ending regardless of language by convention.
All such files go in a folder with their respective language code as name. E.g.:
Norwegian files go into a folder called "nb-NO"
German files go into a folder called "de-DE" 

Alternatively, files can be delivered with their correct language code in the file ending, e.g. da-DK.json for Danish language files.
In this case, the files go in a folder called all-languages.

When language files are placed in their respective fodlers, run translate.rb. Follow instructions to insert files.


When this is done, a branch named language-files has been created and pushed to the Monsenso/web repository. Make a pull request for this branch and remember to assign a developer for reviewing.


