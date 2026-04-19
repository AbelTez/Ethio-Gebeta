#!/bin/bash

# ================================================
# Ethio Gebeta - Ethio Telecom USSD Simulator
# Tree-structured menu like *999#
# ================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Simulated Balance
main_balance=247.50
data_balance=2450   # in MB
voice_balance=120   # in minutes
sms_balance=85

show_header() {
    clear
    echo -e "${GREEN}Welcome to Ethio Telecom Services!${NC}"
    echo -e "${YELLOW}**********************************************${NC}"
    echo ""
}

check_balance() {
    show_header
    echo -e "${CYAN}=== Your Current Balance ===${NC}"
    echo "Main Balance     : ${YELLOW}${main_balance} Birr${NC}"
    echo "Data Balance     : ${YELLOW}$(awk "BEGIN {print $data_balance/1024}") GB${NC}"
    echo "Voice Balance    : ${YELLOW}${voice_balance} Minutes${NC}"
    echo "SMS Balance      : ${YELLOW}${sms_balance} SMS${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

buy_package() {
    local price=$1
    local name=$2
    if (( $(awk "BEGIN {print ($main_balance < $price)}") )); then
        echo -e "${RED}Insufficient balance!${NC}"
    else
        main_balance=$(awk "BEGIN {print $main_balance - $price}")
        echo -e "${GREEN}Success!${NC}"
        echo -e "You have subscribed to: ${YELLOW}$name${NC}"
        echo -e "New Main Balance: ${YELLOW}${main_balance} Birr${NC}"
    fi
    sleep 2
}

main_menu() {
    while true; do
        show_header
        echo "1. Data Packages"
        echo "2. Voice Packages"
        echo "3. SMS Packages"
        echo "4. Combo Packages"
        echo "5. Special Offers"
        echo "6. Check Balance"
        echo "7. Exit"
        echo ""
        read -p "Enter your choice (1-7): " choice

        case $choice in
            1) data_menu ;;
            2) voice_menu ;;
            3) sms_menu ;;
            4) combo_menu ;;
            5) special_menu ;;
            6) check_balance ;;
            7) echo -e "${GREEN}Thank you for using Ethio Gebeta. Goodbye!${NC}"; exit 0 ;;
            *) echo -e "${RED}Invalid option! Try again.${NC}"; sleep 1.5 ;;
        esac
    done
}

data_menu() {
    while true; do
        show_header
        echo -e "${BLUE}=== Data Packages ===${NC}"
        echo "1. Daily Packages"
        echo "2. Weekly Packages"
        echo "3. Monthly Packages"
        echo "4. Night Packages"
        echo "5. Back to Main Menu"
        echo ""
        read -p "Enter choice: " ch

        case $ch in
            1)
                echo -e "${YELLOW}Daily Data Packages:${NC}"
                echo "1. 100MB - 5 Birr"
                echo "2. 300MB - 12 Birr"
                echo "3. 1GB   - 35 Birr"
                read -p "Select package (or 0 to cancel): " p
                case $p in
                    1) buy_package 5 "100MB Daily Data" ;;
                    2) buy_package 12 "300MB Daily Data" ;;
                    3) buy_package 35 "1GB Daily Data" ;;
                esac
                ;;
            2)
                echo -e "${YELLOW}Weekly Data Packages:${NC}"
                echo "1. 700MB  - 55 Birr"
                echo "2. 1.5GB  - 85 Birr"
                echo "3. 4GB    - 195 Birr"
                read -p "Select: " p
                case $p in
                    1) buy_package 55 "700MB Weekly" ;;
                    2) buy_package 85 "1.5GB Weekly" ;;
                    3) buy_package 195 "4GB Weekly" ;;
                esac
                ;;
            5) break ;;
            *) echo -e "${RED}Invalid choice!${NC}"; sleep 1 ;;
        esac
    done
}

voice_menu() {
    while true; do
        show_header
        echo -e "${BLUE}=== Voice Packages ===${NC}"
        echo "1. Daily Voice"
        echo "2. Weekly Voice"
        echo "3. Back"
        echo ""
        read -p "Choose: " ch
        case $ch in
            1)
                echo "1. 25 Min + 25 Night Min - 7 Birr"
                echo "2. 70 Min + 70 Night Min - 18 Birr"
                read -p "Select: " p
                case $p in
                    1) buy_package 7 "25 Min Daily Voice" ;;
                    2) buy_package 18 "70 Min Daily Voice" ;;
                esac
                ;;
            3) break ;;
        esac
    done
}

sms_menu() {
    while true; do
        show_header
        echo -e "${BLUE}=== SMS Packages ===${NC}"
        echo "1. Daily  (100 SMS) - 4 Birr"
        echo "2. Weekly (600 SMS) - 20 Birr"
        echo "3. Back"
        echo ""
        read -p "Choose: " ch
        case $ch in
            1) buy_package 4 "100 Daily SMS" ;;
            2) buy_package 20 "600 Weekly SMS" ;;
            3) break ;;
        esac
    done
}

combo_menu() {
    while true; do
        show_header
        echo -e "${BLUE}=== Combo Packages ===${NC}"
        echo "1. Daily Combo   - 15 Birr (30 Min + 300MB)"
        echo "2. Weekly Combo  - 85 Birr (200 Min + 1.5GB)"
        echo "3. Monthly Combo - 299 Birr (Unlimited Night + 6GB)"
        echo "4. Back"
        echo ""
        read -p "Choose: " ch
        case $ch in
            1) buy_package 15 "Daily Combo" ;;
            2) buy_package 85 "Weekly Combo" ;;
            3) buy_package 299 "Monthly Combo" ;;
            4) break ;;
        esac
    done
}

special_menu() {
    while true; do
        show_header
        echo -e "${BLUE}=== Special Offers ===${NC}"
        echo "1. 1 Birr Daily Pack"
        echo "2. Weekend Unlimited (Saturday & Sunday)"
        echo "3. Social Media Pack (FB, TG, IG) - 10 Birr"
        echo "4. Back"
        echo ""
        read -p "Choose offer: " ch
        case $ch in
            1) buy_package 1 "1 Birr Daily Pack" ;;
            2) buy_package 45 "Weekend Unlimited" ;;
            3) buy_package 10 "Social Media Pack" ;;
            4) break ;;
        esac
    done
}

# Start the application
main_menu