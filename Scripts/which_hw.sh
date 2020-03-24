#!/usr/bin/env bash

# Todo: add concurency option.
# check if I can make strings for each cmd, then evaluate if its the chosen cmd
# add section for projects
# add links to all the andor google docs


# would loooove to have projects with many pdf's be opened
# all in the same tabbed window!!!!!


# ---------- ASSIGNMENT LINKS ------------------------------------------

# ass_520_urls='https://www.cs.mcgill.ca/~cs520/2020/assignments/Assignment2_Specifications.pdf https://www.cs.mcgill.ca/~cs520/2020/assignments/Assignment2.pdf https://www.cs.mcgill.ca/~cs520/2020/assignments/Assignment2_Rubric.pdf'
ass_520_urls='https://www.cs.mcgill.ca/~cs520/2020/project/Milestone2.pdf https://www.cs.mcgill.ca/~cs520/2020/project/Milestone2_Specifications.pdf https://www.cs.mcgill.ca/~cs520/2020/project/Milestone2_Rubric.pdf'

ass_421_pdf='/home/brendon/Downloads/Assignments/db/outline/a2.pdf'
ass_409_pdf='/home/brendon/Downloads/Assignments/concur/assig3.pdf'


# ---------- NOTE LINKS ------------------------------------------

# would be cleaner if I could make the full cmd's here and just be
# able to evaluate them if "Notes" was chosen
notes_520='https://www.cs.mcgill.ca/~cs520/2020/'
notes_409='https://www.cs.mcgill.ca/~phussm/myNotes/409notes/'

# just the mcgill page.
notes_421='https://mycourses2.mcgill.ca/d2l/le/content/427324/Home'
# just the mcgill page.
notes_andor='https://mycourses2.mcgill.ca/d2l/le/lessons/404114/units/4517021'
# xdg-open /home/brendon/Documents/Mcgill/5th-year/fall-sem/andor/Andor_M4_User_Interface_Demo_Handout.pdf



# --------- PROMPTS -----------------------------------------------------------

classes="Databases\nCompilers\nAndor\nConcurrency"
class_choice=$(echo -e "$classes" | dmenu -i -p "Which class link?")
class_choice=$(echo -e "$class_choice" | tr -d '\n')
if [ "$class_choice" == "" ]; then
    exit 1
fi


# should just add a thing for projects instead of a new script!!!


notes_or_assignment=$(echo -e "Assignment\nNotes\nTextbook" | dmenu -i -p "Notes, Assignment, or Textbook?")
# remove trailing newline from selection
notes_or_assignment=$(echo -e "$notes_or_assignment" | tr -d '\n')


if [ "$class_choice" == "Databases" ]; then
# ------------- DATABASES ----------------------------------------------------

    if [ "$notes_or_assignment" == "Notes" ]; then
        /usr/bin/google-chrome-stable --new-window $notes_421
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        xdg-open $ass_421_pdf

    elif [ "$notes_or_assignment" == "Textbook" ]; then
        exit 1
    else
        exit 1
    fi
elif [ "$class_choice" == "Compilers" ]; then
# ------------ COMPILERS -----------------------------------------------------

    if [ "$notes_or_assignment" == "Notes" ]; then
        /usr/bin/google-chrome-stable $notes_520
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        /usr/bin/google-chrome-stable $ass_520_urls

    elif [ "$notes_or_assignment" == "Textbook" ]; then
        exit 1
    else
        exit 1
    fi
elif [ "$class_choice" == "Concurrency" ]; then
# ------------ CONCURRENCY -----------------------------------------------------

    if [ "$notes_or_assignment" == "Notes" ]; then
        /usr/bin/google-chrome-stable  $notes_409
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        xdg-open "$ass_409_pdf"

    elif [ "$notes_or_assignment" == "Textbook" ]; then
        exit 1
    else
        exit 1
    fi
else
# ------------ ANDOR -----------------------------------------------------------

# should make an option to open all of the google docs here !!!!!!!!!!
    if [ "$notes_or_assignment" == "Notes" ]; then
        /usr/bin/google-chrome-stable $notes_andor
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        xdg-open /home/brendon/Documents/Mcgill/5th-year/fall-sem/andor/Andor_M4_User_Interface_Demo_Handout.pdf
    else
        return
    fi
fi


# how to make better:
# add support for viewing projects somehow
# add option to open in a new tab instead of a new window always
# make it so I can open all andor design documents!!!


# ctrl+t: open/goto new tab.
# ctrl+l: select text in addy bar
# ctrl+v: paste the link
# xdotool key ctrl+t ctrl+l ctrl+v 

# -- havent test this as is, but might have to look into the --window argument to
# -- xdotool


