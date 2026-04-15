# -------- STATE --------
balance = 100
current_menu = "MAIN"
page = 0
history = []
is_gift_mode = False

# -------- PACKAGE DATA --------

packages = {
    "INTERNET": {
        "DAILY": [("100MB", 5), ("200MB", 10), ("300MB", 15)],
        "WEEKLY": [("500MB", 15), ("1GB", 22)],
        "MONTHLY": [("2GB", 35), ("4GB", 60)]
    },
    "VOICE": {
        "DAILY": [("10 Min", 3), ("30 Min", 8), ("60 Min", 15)],
        "WEEKLY": [("120 Min", 18), ("300 Min", 35)],
        "MONTHLY": [("1000 Min", 80), ("2000 Min", 140)]
    },
    "SOCIAL": {
        "DAILY": [("WhatsApp + Telegram", 5), ("All Apps", 10)],
        "WEEKLY": [("Social Pack Small", 20), ("Social Pack Large", 35)],
        "MONTHLY": [("Unlimited Social", 70), ("Premium Social", 120)]
    }
}

# -------- HELPERS --------

def show(options, page):
    start = page * 4
    end = start + 4

    i = start
    count = 1

    while i < end and i < len(options):
        print(str(count) + ". " + options[i])
        i += 1
        count += 1

    if len(options) > end:
        print("#. Next")

    if len(history) > 0:
        print("##. Back")

    if current_menu != "MAIN":
        print("**. Main Menu")


def get_input():
    print("Enter: ", end="", flush=True)
    return input().strip()


def invalid():
    print("Invalid input, try again.")


def is_number(s):
    if s == "":
        return False
    for c in s:
        if c < '0' or c > '9':
            return False
    return True


def valid_phone(p):
    if len(p) != 10:
        return False
    if not (p[0] == '0' and p[1] == '9'):
        return False
    for c in p:
        if c < '0' or c > '9':
            return False
    return True


def success(name, price):
    global balance
    balance -= price
    print("\nYou have successfully purchased " + name + " for Br." + str(price))
    print("Remaining balance: Br." + str(balance))
    print("Thank you for using ethio gebeta.")
    exit()


def handle_purchase(name, price):
    global is_gift_mode, balance

    if balance < price:
        print("Insufficient balance.")
        return

    # -------- GIFT FLOW --------
    if is_gift_mode:
        while True:
            phone = input("Enter receiver phone (09XXXXXXXX): ")
            if not valid_phone(phone):
                print("Invalid phone number.")
                continue
            break

    confirm = input("Enter 1 to confirm: ")

    if confirm == "1":
        success(name, price)
    else:
        print("Cancelled.")


# -------- MAIN LOOP --------

while True:

    # -------- MAIN MENU --------
    if current_menu == "MAIN":
        options = ["Internet", "Voice", "Social Media"]

        print("\n*999#")
        show(options, page)

        choice = get_input()

        if choice == "#":
            page += 1
            continue
        elif choice == "##":
            page = 0
            continue
        elif choice == "**":
            current_menu = "MAIN"
            page = 0
            continue

        if not is_number(choice):
            invalid()
            continue

        index = int(choice) - 1 + page * 4

        if index == 0:
            history.append(("MAIN", page))
            current_menu = "INTERNET"
        elif index == 1:
            history.append(("MAIN", page))
            current_menu = "VOICE"
        elif index == 2:
            history.append(("MAIN", page))
            current_menu = "SOCIAL"
        else:
            invalid()
            continue

        page = 0
        continue


    # -------- SERVICE MENU --------
    elif current_menu in ["INTERNET", "VOICE", "SOCIAL"]:
        options = ["For Self", "For Gift"]

        print("\n" + current_menu)
        show(options, page)

        choice = get_input()

        if choice == "##":
            current_menu, page = history.pop()
            continue
        elif choice == "**":
            current_menu = "MAIN"
            page = 0
            continue

        if not is_number(choice):
            invalid()
            continue

        if choice == "1":
            is_gift_mode = False
        elif choice == "2":
            is_gift_mode = True
        else:
            invalid()
            continue

        history.append((current_menu, page))
        current_menu = current_menu + "_SELF"
        page = 0
        continue


    # -------- PACKAGE TYPE MENU --------
    elif current_menu.endswith("_SELF"):
        options = ["Daily", "Weekly", "Monthly"]

        print("\n" + current_menu)
        show(options, page)

        choice = get_input()

        if choice == "##":
            current_menu, page = history.pop()
            continue
        elif choice == "**":
            current_menu = "MAIN"
            page = 0
            continue

        if not is_number(choice):
            invalid()
            continue

        if choice == "1":
            current_menu = current_menu + "_DAILY"
        elif choice == "2":
            current_menu = current_menu + "_WEEKLY"
        elif choice == "3":
            current_menu = current_menu + "_MONTHLY"
        else:
            invalid()
            continue

        page = 0
        continue


    # -------- PACKAGE LIST --------
    elif (
        current_menu.endswith("_DAILY") or
        current_menu.endswith("_WEEKLY") or
        current_menu.endswith("_MONTHLY")
    ):

        service = current_menu.split("_")[0]

        if current_menu.endswith("_DAILY"):
            period = "DAILY"
        elif current_menu.endswith("_WEEKLY"):
            period = "WEEKLY"
        else:
            period = "MONTHLY"

        data = packages[service][period]

        options = []
        i = 0
        while i < len(data):
            options.append(data[i][0] + " Br." + str(data[i][1]))
            i += 1

        print("\nPackages")
        show(options, page)

        choice = get_input()

        if choice == "#":
            page += 1
            continue
        elif choice == "##":
            current_menu, page = history.pop()
            continue
        elif choice == "**":
            current_menu = "MAIN"
            page = 0
            continue

        if not is_number(choice):
            invalid()
            continue

        index = int(choice) - 1 + page * 4

        if index < 0 or index >= len(data):
            invalid()
            continue

        name = data[index][0]
        price = data[index][1]

        handle_purchase(name, price)
        continue