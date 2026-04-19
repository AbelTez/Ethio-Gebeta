balance = 100


# -------- Helpers --------
def is_valid_phone(phone):
    return (phone.startswith("09") and len(phone) == 10 and phone.isdigit()) or \
           (phone.startswith("2519") and len(phone) == 12 and phone.isdigit())


def confirm_and_process(price, desc, mode):
    global balance

    if mode == "gift":
        while True:
            phone = input("Enter receiver phone: ")
            if is_valid_phone(phone):
                break
        print(f"You chose {desc} for {phone}")
    else:
        print(f"You chose {desc}")

    c = input("Enter 1 to confirm, any other to cancel: ")
    if c == "1":
        if balance < price:
            print("Insufficient balance")
            exit()
        balance -= price
        print(f"Success! Remaining balance: {balance}")
        exit()
    else:
        exit()


# -------- Menus --------
def daily_menu(mode, category):
    while True:
        if category == "internet":
            print("1. 5 birr for 100 Mb")
            print("2. 10 birr for 200 Mb")
            print("3. 15 birr for 300 Mb")
        elif category == "voice":
            print("1. 5 birr for 20 Mn")
            print("2. 10 birr for 42 Mn")
            print("3. 15 birr for 65 Mn")
        elif category == "social":
            print("1. 20 birr for 1.2 Gb TG")
            print("2. 39 birr for 2 Gb FB/YT")
        elif category == "combo":
            print("1. 15 birr for 20 Mn + 200 Mb")
            print("2. 25 birr for 30 Mn + 420 Mb")

        print("*. Back")
        c = input("Enter: ")

        if c == "*":
            return

        mapping = {
            ("internet", "1"): (5, "100Mb"),
            ("internet", "2"): (10, "200Mb"),
            ("internet", "3"): (15, "300Mb"),

            ("voice", "1"): (5, "20Min"),
            ("voice", "2"): (10, "42Min"),
            ("voice", "3"): (15, "65Min"),

            ("social", "1"): (20, "1.2GB TG"),
            ("social", "2"): (39, "2GB FB/YT"),

            ("combo", "1"): (15, "20Min+200Mb"),
            ("combo", "2"): (25, "30Min+420Mb"),
        }

        if (category, c) in mapping:
            price, desc = mapping[(category, c)]
            confirm_and_process(price, desc, mode)


def weekly_menu(mode, category):
    while True:
        if category == "internet":
            print("1. 50 birr for 650 Mb")
            print("2. 70 birr for 1 Gb")
            print("3. 140 birr for 2.5 Gb")
        elif category == "voice":
            print("1. 25 birr for 70 Mn")
            print("2. 35 birr for 110 Mn")
            print("3. 45 birr for 145 Mn")
        elif category == "social":
            print("1. 80 birr for 3 Gb TG")
            print("2. 100 birr for 4 Gb FB/YT")
        elif category == "combo":
            print("1. 30 birr for 40 Mn + 100 Mb")
            print("2. 50 birr for 55 Mn + 320 Mb")

        print("*. Back")
        c = input("Enter: ")

        if c == "*":
            return

        mapping = {
            ("internet", "1"): (50, "650Mb"),
            ("internet", "2"): (70, "1GB"),
            ("internet", "3"): (140, "2.5GB"),

            ("voice", "1"): (25, "70Min"),
            ("voice", "2"): (35, "110Min"),
            ("voice", "3"): (45, "145Min"),

            ("social", "1"): (80, "3GB TG"),
            ("social", "2"): (100, "4GB FB/YT"),

            ("combo", "1"): (30, "40Min+100Mb"),
            ("combo", "2"): (50, "55Min+320Mb"),
        }

        if (category, c) in mapping:
            price, desc = mapping[(category, c)]
            confirm_and_process(price, desc, mode)


def monthly_menu(mode, category):
    while True:
        if category == "internet":
            print("1. 82 birr for 1 Gb")
            print("2. 150 birr for 2 Gb")
            print("3. 280 birr for 4 Gb")
        elif category == "voice":
            print("1. 82 birr for 1 Mn")
            print("2. 150 birr for 2 Mn")
            print("3. 280 birr for 4 Mn")
        elif category == "social":
            print("1. 110 birr for 4 Gb TG")
            print("2. 300 birr for 10 Gb FB/YT")
        elif category == "combo":
            print("1. 80 birr for 120 Mn + 850 Mb")
            print("2. 120 birr for 230 Mn + 1 Gb")

        print("*. Back")
        c = input("Enter: ")

        if c == "*":
            return

        mapping = {
            ("internet", "1"): (82, "1GB"),
            ("internet", "2"): (150, "2GB"),
            ("internet", "3"): (280, "4GB"),

            ("voice", "1"): (82, "1Min"),
            ("voice", "2"): (150, "2Min"),
            ("voice", "3"): (280, "4Min"),

            ("social", "1"): (110, "4GB TG"),
            ("social", "2"): (300, "10GB FB/YT"),

            ("combo", "1"): (80, "120Min+850Mb"),
            ("combo", "2"): (120, "230Min+1GB"),
        }

        if (category, c) in mapping:
            price, desc = mapping[(category, c)]
            confirm_and_process(price, desc, mode)


def package_menu(mode, category):
    while True:
        print("1. Daily")
        print("2. Weekly")
        print("3. Monthly")
        print("*. Back")
        print("**. Main Menu")
        c = input("Enter: ")

        if c == "1":
            daily_menu(mode, category)
        elif c == "2":
            weekly_menu(mode, category)
        elif c == "3":
            monthly_menu(mode, category)
        elif c == "*":
            return
        elif c == "**":
            main_menu()


def category_entry(category):
    while True:
        print("1. For Self")
        print("2. For Gift")
        print("**. Main Menu")
        c = input("Enter: ")

        if c == "1":
            package_menu("self", category)
        elif c == "2":
            package_menu("gift", category)
        elif c == "**":
            main_menu()


def telebirr_menu():
    while True:
        print("Welcome to Telebirr")
        print("0. Change PIN")
        print("1. Financial Service")
        print("2. Send Money")
        print("3. Airtime")
        print("00. Main Menu")
        c = input("Enter: ")

        if c == "00":
            return
        else:
            print("Service not yet available. We will fix soon.")


def main_menu():
    while True:
        print("Welcome to ethiotelecom")
        print("1. Internet")
        print("2. Voice")
        print("3. Social Media")
        print("#. Next")
        c = input("Enter: ")

        if c == "1":
            category_entry("internet")
        elif c == "2":
            category_entry("voice")
        elif c == "3":
            category_entry("social")
        elif c == "#":
            while True:
                print("4. Voice + Internet")
                print("5. Telebirr")
                print("##. Previous")
                c2 = input("Enter: ")

                if c2 == "4":
                    category_entry("combo")
                elif c2 == "5":
                    telebirr_menu()
                elif c2 == "##":
                    break


# -------- Start --------
main_menu()