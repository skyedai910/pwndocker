#!/bin/bash
while getopts n:h OPT; do #选项后面的冒号表示该选项需要参数
  case ${OPT} in
    n) ctf_name=${OPTARG}
      ;;
    h)
       printf "[Usage] `date '+%F %T'` `basename $0` -n <ctf_name:pwn4skye>\n" >&2
       exit 1
       ;;
  esac
done

# check parameter
if [ -z "${ctf_name}" ]
then
    printf "[ERROR] `date '+%F %T'` following parameters is empty:\nctf_name=${ctf_name}\n"
    exit 1
else
    exec docker run -d \
    --rm \
    -h ${ctf_name} \
    --name ${ctf_name} \
    -v $(pwd)/${ctf_name}:/ctf/work \
    -p 23946:23946 \
    --cap-add=SYS_PTRACE \
    skye231/pwndocker:20.04
    printf "[SUCCESS] Docker <${ctf_name}> created.\n"
fi
