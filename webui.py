import sys

print("Running with Python interpreter located at: ", sys.prefix)
print("Python Version: ", sys.version)


if __name__ == '__main__':
    print("This is __main__")

else:
    print("Not __main__")