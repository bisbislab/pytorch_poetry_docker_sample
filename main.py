import torch


def main():
    if torch.cuda.is_available():
        print("CUDA is available!")
    else:
        print("CUDA is NOT available...")


if __name__ == "__main__":
    main()
