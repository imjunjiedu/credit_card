# -*- coding: utf-8 -*-
"""
Spyder Editor

Written by JJ(junjie du). Date:09/17/2019

This is a Homework for BA position with Citigroup China (Ltd).
"""

print("Citi Credit Card Service..")
print("Welcome to Citibank mobile service")
print("Swipe your card here:")
atm_pin=123456
"""here we are storing pin atm_pin"""
transaction=["Credit Card Balance", "Cash Advance", "Transfer from Debit/Saving Account", 
             "Change your PIN", "Increase your Credit Limit", "Quit"]
"""here we are storing all transactions"""
pin=input("enter your pin to proceed")
if pin==123456:
    """if pin correct then it will go to transactions or other
    functions otherwise it wont go thru"""
    print("Choose your transaction below:")
    print("1. Credit Card Balance")
    print("2. Cash Advance")
    print("3. Transfer from Debit/Saving Account")
    print("4. Change your PIN")
    print("5. Increase your Credit Limit")
    print("6. Quit")
    trans=input("transaction:")
    if trans=="Credit Card Balance":
        check=input("show your balance")
        if check=="yes":
            print("here is your balance! thanks for using Citibank!")
        else:
            print("thanks for using Citibank")
    elif trans=="Cash Advance":
        amount=input("enter the amount to proceed:")
        if amount>0:
            print("collect your cash, thanks for using Citibank")
        else:
            print("enter valid amount to proceed")
    elif trans=="Transfer from Debit/Saving Account":
        transfer=input("enter the amount to transfer:")
        if transfer >0:
            print("your transfer has been successfully made, thanks for using Citibank")
        else:
            print("enter valid amount to proceed")
    elif trans=="Change your PIN":
        change_pin=input("enter your new pin:")
        if change_pin >0:
            print("your pin has been successfully change! thanks for using Citibank")
        else:
            print("enter valid pin to proceed")
    elif trans=="Increase your Credit Limit":
        increase_limit=input("enter your new credit limit:")
        if increase_limit >0:
            print("your credit limit request has been submitted successfully! thanks for using Citibank")
        else:
            print("your request is under reviewing or contact Citi customer service for help")
    elif trans=="Quit":
        quit_1=input("press yes to quit")
        if quit_1=="yes":
            print("quit")
        else:
            "Choose your transaction below:"

else:
    print("wrong pin!, please try again")

"""END"""
            




       
            
            
            
    
    



