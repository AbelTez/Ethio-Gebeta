#!/bin/bash

balance=100

# -------- Helpers --------
is_valid_phone() {
  [[ $1 =~ ^(09[0-9]{8}|2519[0-9]{8})$ ]]
}

confirm_and_process() {
  local price=$1
  local desc="$2"
  local type="$3"

  if [ "$type" == "gift" ]; then
    while true; do
      read -p "Enter receiver phone: " phone
      if is_valid_phone "$phone"; then
        break
      fi
    done
    echo "You chose $desc for $phone"
  else
    echo "You chose $desc"
  fi

  read -p "Enter 1 to confirm, any other to cancel: " c
  if [ "$c" == "1" ]; then
    if (( balance < price )); then
      echo "Insufficient balance"
      exit
    fi
    balance=$((balance - price))
    echo "Success! Remaining balance: $balance"
    exit
  else
    exit
  fi
}

# -------- Package Menus --------
package_menu() {
  local type=$1   # self or gift
  local category=$2

  while true; do
    echo "1. Daily"
    echo "2. Weekly"
    echo "3. Monthly"
    echo "*. Back"
    echo "**. Main Menu"
    read -p "Enter: " c

    case $c in
      1) daily_menu "$type" "$category" ;;
      2) weekly_menu "$type" "$category" ;;
      3) monthly_menu "$type" "$category" ;;
      "*") return ;;
      "**") main_menu ;;
    esac
  done
}

daily_menu() {
  local type=$1
  local cat=$2

  while true; do
    case $cat in
      internet)
        echo "1. 5 birr for 100 Mb"
        echo "2. 10 birr for 200 Mb"
        echo "3. 15 birr for 300 Mb"
        ;;
      voice)
        echo "1. 5 birr for 20 Mn"
        echo "2. 10 birr for 42 Mn"
        echo "3. 15 birr for 65 Mn"
        ;;
      social)
        echo "1. 20 birr for 1.2 Gb TG"
        echo "2. 39 birr for 2 Gb FB/YT"
        ;;
      combo)
        echo "1. 15 birr for 20 Mn + 200 Mb"
        echo "2. 25 birr for 30 Mn + 420 Mb"
        ;;
    esac

    echo "*. Back"
    read -p "Enter: " c

    case "$cat-$c" in
      internet-1) confirm_and_process 5 "100Mb" "$type" ;;
      internet-2) confirm_and_process 10 "200Mb" "$type" ;;
      internet-3) confirm_and_process 15 "300Mb" "$type" ;;

      voice-1) confirm_and_process 5 "20Min" "$type" ;;
      voice-2) confirm_and_process 10 "42Min" "$type" ;;
      voice-3) confirm_and_process 15 "65Min" "$type" ;;

      social-1) confirm_and_process 20 "1.2GB TG" "$type" ;;
      social-2) confirm_and_process 39 "2GB FB/YT" "$type" ;;

      combo-1) confirm_and_process 15 "20Min+200Mb" "$type" ;;
      combo-2) confirm_and_process 25 "30Min+420Mb" "$type" ;;
      "*") return ;;
    esac
  done
}

weekly_menu() {
  local type=$1
  local cat=$2

  while true; do
    case $cat in
      internet)
        echo "1. 50 birr for 650 Mb"
        echo "2. 70 birr for 1 Gb"
        echo "3. 140 birr for 2.5 Gb"
        ;;
      voice)
        echo "1. 25 birr for 70 Mn"
        echo "2. 35 birr for 110 Mn"
        echo "3. 45 birr for 145 Mn"
        ;;
      social)
        echo "1. 80 birr for 3 Gb TG"
        echo "2. 100 birr for 4 Gb FB/YT"
        ;;
      combo)
        echo "1. 30 birr for 40 Mn + 100 Mb"
        echo "2. 50 birr for 55 Mn + 320 Mb"
        ;;
    esac

    echo "*. Back"
    read -p "Enter: " c

    case "$cat-$c" in
      internet-1) confirm_and_process 50 "650Mb" "$type" ;;
      internet-2) confirm_and_process 70 "1GB" "$type" ;;
      internet-3) confirm_and_process 140 "2.5GB" "$type" ;;

      voice-1) confirm_and_process 25 "70Min" "$type" ;;
      voice-2) confirm_and_process 35 "110Min" "$type" ;;
      voice-3) confirm_and_process 45 "145Min" "$type" ;;

      social-1) confirm_and_process 80 "3GB TG" "$type" ;;
      social-2) confirm_and_process 100 "4GB FB/YT" "$type" ;;

      combo-1) confirm_and_process 30 "40Min+100Mb" "$type" ;;
      combo-2) confirm_and_process 50 "55Min+320Mb" "$type" ;;
      "*") return ;;
    esac
  done
}

monthly_menu() {
  local type=$1
  local cat=$2

  while true; do
    case $cat in
      internet)
        echo "1. 82 birr for 1 Gb"
        echo "2. 150 birr for 2 Gb"
        echo "3. 280 birr for 4 Gb"
        ;;
      voice)
        echo "1. 82 birr for 1 Mn"
        echo "2. 150 birr for 2 Mn"
        echo "3. 280 birr for 4 Mn"
        ;;
      social)
        echo "1. 110 birr for 4 Gb TG"
        echo "2. 300 birr for 10 Gb FB/YT"
        ;;
      combo)
        echo "1. 80 birr for 120 Mn + 850 Mb"
        echo "2. 120 birr for 230 Mn + 1 Gb"
        ;;
    esac

    echo "*. Back"
    read -p "Enter: " c

    case "$cat-$c" in
      internet-1) confirm_and_process 82 "1GB" "$type" ;;
      internet-2) confirm_and_process 150 "2GB" "$type" ;;
      internet-3) confirm_and_process 280 "4GB" "$type" ;;

      voice-1) confirm_and_process 82 "1Min" "$type" ;;
      voice-2) confirm_and_process 150 "2Min" "$type" ;;
      voice-3) confirm_and_process 280 "4Min" "$type" ;;

      social-1) confirm_and_process 110 "4GB TG" "$type" ;;
      social-2) confirm_and_process 300 "10GB FB/YT" "$type" ;;

      combo-1) confirm_and_process 80 "120Min+850Mb" "$type" ;;
      combo-2) confirm_and_process 120 "230Min+1GB" "$type" ;;
      "*") return ;;
    esac
  done
}

# -------- Category Entry --------
category_entry() {
  local cat=$1
  while true; do
    echo "1. For Self"
    echo "2. For Gift"
    echo "**. Main Menu"
    read -p "Enter: " c

    case $c in
      1) package_menu "self" "$cat" ;;
      2) package_menu "gift" "$cat" ;;
      "**") main_menu ;;
    esac
  done
}

# -------- Telebirr --------
telebirr_menu() {
  while true; do
    echo "Welcome to Telebirr"
    echo "0. Change PIN"
    echo "1. Financial Service"
    echo "2. Send Money"
    echo "3. Airtime"
    echo "00. Main Menu"
    read -p "Enter: " c

    if [ "$c" == "00" ]; then
      main_menu
    else
      echo "Service not yet available. We will fix soon."
    fi
  done
}

# -------- Main Menu --------
main_menu() {
  while true; do
    echo "Welcome to ethiotelecom"
    echo "1. Internet"
    echo "2. Voice"
    echo "3. Social Media"
    echo "#. Next"
    read -p "Enter: " c

    case $c in
      1) category_entry "internet" ;;
      2) category_entry "voice" ;;
      3) category_entry "social" ;;
      "#")
        while true; do
          echo "4. Voice + Internet"
          echo "5. Telebirr"
          echo "##. Previous"
          read -p "Enter: " c2

          case $c2 in
            4) category_entry "combo" ;;
            5) telebirr_menu ;;
            "##") break ;;
          esac
        done
        ;;
    esac
  done
}

# -------- Start --------
main_menu