#!/usr/bin/env bash

# Todo: add concurency option.
# check if I can make strings for each cmd, then evaluate if its the chosen cmd
# add section for projects
# add links to all the andor google docs


# ---------- ASSIGNMENT LINKS ------------------------------------------

ass_atoc_pdf='/home/brendon/Downloads/Assignments/atmosphere/ATOC181_Assignment1.pdf'
atoc_textbook='/home/brendon/Downloads/1-Classes/textbooks/atmosphere_textbook.pdf'
ass_326_pdf='/home/brendon/Downloads/Assignments/326/326_M1.pdf'

# ass_520_urls='https://www.cs.mcgill.ca/~cs520/2020/assignments/Assignment2_Specifications.pdf https://www.cs.mcgill.ca/~cs520/2020/assignments/Assignment2.pdf https://www.cs.mcgill.ca/~cs520/2020/assignments/Assignment2_Rubric.pdf'
ass_520_urls='https://www.cs.mcgill.ca/~cs520/2020/project/Milestone4.pdf https://www.cs.mcgill.ca/~cs520/2020/project/Milestone4_Rubric.pdf'

ass_421_pdf='/home/brendon/Downloads/Assignments/db/milestone3/p3.pdf'
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

# \nConcurrency
classes="326\n429\nProgramming challenges\nAtmosphere\nchem"
class_choice=$(echo -e "$classes" | rofi -dmenu -i "Which class link?")
class_choice=$(echo -e "$class_choice" | tr -d '\n')
if [ "$class_choice" == "" ]; then
    exit 1
fi


# should just add a thing for projects instead of a new script!!!


notes_or_assignment=$(echo -e "Assignment\nNotes\nTextbook" | rofi -dmenu -i "Notes, Assignment, or Textbook?")
# remove trailing newline from selection
notes_or_assignment=$(echo -e "$notes_or_assignment" | tr -d '\n')


if [ "$class_choice" == "Programming challenges" ]; then
# ------------- Comp 321 -------------------------------------------------------

    if [ "$notes_or_assignment" == "Notes" ]; then
        # /usr/bin/google-chrome-stable --new-window $notes_421
        exit 1
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        exit 1

    elif [ "$notes_or_assignment" == "Textbook" ]; then
        exit 1
    else
        exit 1
    fi
elif [ "$class_choice" == "326" ]; then
# ------------ 326 -------------------------------------------------------------

    if [ "$notes_or_assignment" == "Notes" ]; then
        # /usr/bin/google-chrome-stable $notes_520
        exit 1
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        xdg-open  $ass_326_pdf

    elif [ "$notes_or_assignment" == "Textbook" ]; then
        exit 1
    else
        exit 1
    fi
elif [ "$class_choice" == "429" ]; then
# ------------ 429 -------------------------------------------------------------

    if [ "$notes_or_assignment" == "Notes" ]; then
        # /usr/bin/google-chrome-stable  $notes_409
        exit 1
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        xdg-open "$ass_409_pdf"

    elif [ "$notes_or_assignment" == "Textbook" ]; then
        exit 1
    else
        exit 1
    fi
elif [ "$class_choice" == "Atmosphere" ]; then
# ------------ ATOC -----------------------------------------------------------

# should make an option to open all of the google docs here !!!!!!!!!!
    if [ "$notes_or_assignment" == "Notes" ]; then
        # /usr/bin/google-chrome-stable $notes_andor
        # I never think to use this
        /usr/bin/kitty -e -d /home/brendon/Documents/Mcgill/6th-year/Atmosphere
        exit 1
    elif [ "$notes_or_assignment" == "Assignment" ]; then
        xdg-open $ass_atoc_pdf
    elif [ "$notes_or_assignment" == "Textbook" ]; then
        xdg-open $atoc_textbook
    else
        exit 1
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


