#!/bin/sh

get_digit_config() {
    case "$1" in 
        1) echo "R,R,R,R,R
                 _,_,_,_,_
                 _,_,_,_,_
                 _,_,_,_,_"
            ;;
        2) echo "_,R,_,_,R
                 R,_,R,_,R
                 R,_,R,_,R
                 R,_,_,R,R"
            ;;
        3) echo "_,R,_,R,_
                 R,_,R,_,R
                 R,_,R,_,R
                 R,_,_,_,R"
            ;;
        4) echo "R,R,R,R,R
                 _,_,R,_,_
                 _,_,R,_,_
                 R,R,R,_,_"
            ;;
        5) echo "R,_,_,R,_
                 R,_,R,_,R
                 R,_,R,_,R
                 R,R,R,_,R"
            ;;
        6) echo "_,_,_,R,_
                 R,_,R,_,R
                 R,_,R,_,R
                 _,R,R,R,_"
            ;;
        7) echo "R,_,_,_,_
                 R,R,_,_,_
                 R,_,R,R,R
                 R,_,_,_,_"
            ;;
        8) echo "_,R,_,R,_
                 R,_,R,_,R
                 R,_,R,_,R
                 _,R,_,R,_"
            ;;
        9) echo "_,R,R,R,_
                 R,_,R,_,R
                 R,_,R,_,R
                 _,R,_,_,_"
            ;;
        0) echo "_,R,R,R,_
                 R,_,_,_,R
                 R,_,_,_,R
                 _,R,R,R,_"
            ;;
        A) echo "_,R,R,R,R
                 R,_,R,_,_
                 R,_,R,_,_
                 _,R,R,R,R"
            ;;
        B) echo "_,R,_,R,_
                 R,_,R,_,R
                 R,_,R,_,R
                 R,R,R,R,R"
            ;;
        C) echo "R,_,_,_,R
                 R,_,_,_,R
                 R,_,_,_,R
                 _,R,R,R,_"
        ;;         
        D) echo "_,R,R,R,_
                 R,_,_,_,R
                 R,_,_,_,R
                 R,R,R,R,R"
        ;;
        E) echo "R,_,_,_,R
                 R,_,R,_,R
                 R,_,R,_,R
                 R,R,R,R,R"
        ;;
        F) echo "R,_,_,_,_
                 R,_,R,_,_
                 R,_,R,_,_
                 R,R,R,R,R"
        ;;
        G) echo "_,R,_,R,R
                 R,_,_,_,R
                 R,_,_,_,R
                 _,R,R,R,R"
        ;;
        H) echo "R,R,R,R,R
                 _,_,R,_,_
                 _,_,R,_,_
                 R,R,R,R,R"
        ;;
        -) echo "_,_,_,_,_
                 _,_,_,_,_
                 _,_,_,_,_
                 _,_,_,_,_"
            ;;
    esac
}


# Function to draw two digits
draw_two_digits() {

    digit1="$1"
    configs1=$(get_digit_config "$digit1")
    IFS=$'\n' read -r -d '' -a config1_array <<< "$configs1" # Split into an array

    digit2="$2"
    configs2=$(get_digit_config "$digit2")
    IFS=$'\n' read -r -d '' -a config2_array <<< "$configs2" # Split into an array
    
    combined_array=()
    # Loop through both arrays and concatenate their elements
    for i in "${!config1_array[@]}"; do
        
        fh=$(echo "${config1_array[i]}" | sed -e 's/_/000000/g' -e 's/R/F90000/g' -e 's/G/00F900/g' -e 's/B/0000F9/g' -e 's/W/000000/g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        sh=$(echo "${config2_array[i]}" | sed -e 's/_/000000/g' -e 's/R/F90000/g' -e 's/G/00F900/g' -e 's/B/0000F9/g' -e 's/W/000000/g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

        combined_array+=(" -d $((3 - i)) -c $fh,000000,$sh,000000")
    done

   echo "./openrgb --noautoconnect ${combined_array[@]}" 
}

draw_two_digits $1 $2
