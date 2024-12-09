#!/bin/bash

if [[ $# -ne 1 || $1 -le 0 ]]; then
  echo "Usage: $0 <positive number>"
  exit 1
fi

number=$1
half=$((number / 2))

# Учитываем нечетные числа
if ((number % 2 == 1)); then
  mid=$((half + 1))
else
  mid=$half
fi

# Вычисляем произведение первой половины
mult=1
for ((i = 1; i <= half; i++)); do
  mult=$((mult * i))
done

# Вычисляем сумму второй половины
sum=0
for ((i = mid + 1; i <= number; i++)); do
  sum=$((sum + i))
done

echo "mult : $mult"
echo "sum: $sum"
