
gadgets=( \
)

for gadget in $gadgets; do
    source `dirname $0`/gadgets/$gadget.zsh
done


unset gadgets
