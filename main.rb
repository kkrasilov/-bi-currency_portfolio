# Бивалютный портфель
require_relative 'lib/currency_reader'

begin
  usd_rate = CurrencyReader.read_currency_from_url

  success = true

rescue SocketError
  puts 'Warning! К сожалению мы не можем соедениться с сервером.'
end

if success
  puts "Текущий курс доллара: #{usd_rate}"
else
  puts 'Введите курс доллара: '
  usd_rate = gets.to_f
end

puts 'Сколько у Вас рублей?'
rub_user = gets.to_f #узнамем сколько рублей у пользователя
puts 'Сколько у Вас долларов?'
usd_user = gets.to_f #узнамем сколько долларов у пользователя

usd_in_rub = usd_user * usd_rate #переводим доллары в рубли для сравниения

balance = (rub_user - (usd_in_rub + rub_user) / 2).round(2) #балансируем портфель

if balance.zero? #портфель сбалансирован
  puts 'Ваш портфель сбалансирован, ничего менять не нужно!'
elsif balance < 1 #долларов больше чем рублей
  puts "Вам надо обменять #{(balance.abs / usd_rate).round(2)} $"
else
  puts "Вам надо обменять #{balance} рублей" #рублей больше чем долларов
end
