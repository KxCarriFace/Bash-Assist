repo() {
    case "$1" in 
    # change the sample direct path to the folder that holds the repository
        "school") cd /c/Users/direct/path/to/directory/School
        ;;
        "work") cd /c/Users/direct/path/to/directory/Work
        ;;
        *) echo "Uknown repo: $1"
        return 1
    ;;
    esac
}

# Command Example:
# repo school