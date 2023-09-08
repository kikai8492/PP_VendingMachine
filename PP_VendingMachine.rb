class VendingMachine

  MONEY = [10, 50, 100, 500, 1000].freeze
  
  def initialize
    @slot_money = 0
    @juice = {name: "コーラ", price: 120, stock: 5}
    @sales_money = 0
  end

  def slot_money
    while true#ユーザーが購入処理or返金に移るまで繰り返す
      puts "お金を投入してください"
      money = gets.chomp.to_i
      if MONEY.include?(money)
        @slot_money += money
      else
        puts "10円玉、50円玉、100円玉、500円玉、1000円札以外は使用できません。#{money}円を返金します。"
      end
      puts "現在の金額は#{@slot_money}円です。投入金額は以上ですか？"
      puts "以上です：1"
      puts "追加する：2"
      puts "払い戻す：3"
      num = gets.chomp.to_i
      if num == 1 && @slot_money >= @juice[:price]
        return false
      elsif num == 1 && @slot_money < @juice[:price]
        puts "投入金額が不足しています"
      elsif num == 2
        true
      elsif num == 3
        puts "#{@slot_money}円を返金します"
        exit
      else
        while num != 1 || num != 2 || num != 3
          puts "1~3を入力してください"
          puts "以上です：1"
          puts "追加する：2"
          puts "払い戻す：3"
          num = gets.chomp.to_i
          if num == 1 && @slot_money >= @juice[:price]
            return false
          elsif num == 1 && @slot_money < @juice[:price]
            puts "投入金額が不足しています"
            break
          elsif num == 2
            break
          elsif num == 3
            puts "#{@slot_money}円を返金します"
            exit
          end
        end
      end
    end
  end

  def current_slot_money
    puts "合計金額は#{@slot_money}円です。"
    puts "購入に移る：1"
    puts "払い戻す：2"
    while true
      num = gets.chomp.to_i
      if num == 1
        return "購入の処理に続く"
      elsif num == 2
        puts "#{@slot_money}円を返金します"
        exit
      else
        puts "1か2を入力してください"
        puts "購入に移る：1"
        puts "払い戻す：2"
      end
    end
  end

  def buy
    while @slot_money >= @juice[:price] && @juice[:stock] > 0
      puts "購入可能商品は以下の通り"
      puts "欲しい商品の番号を入力してください"
      puts "番号1:#{@juice[:name]}、#{@juice[:price]}円、残り#{@juice[:stock]}個"
      num = gets.chomp.to_i
      if num == 1
        puts "#{@juice[:name]}を購入しました"
        @juice[:stock] -= 1
        @slot_money -= @juice[:price]
        @sales_money += @juice[:price]
        puts "残金は#{@slot_money}円です"
        puts "売上金額は#{@sales_money}円です"
        if @slot_money == 0
          puts "#{@slot_money}円を返金します"
          exit
        end
        puts "追加で購入する：1"
        puts "払い戻す：2"
        while true
          num = gets.chomp.to_i
          if num == 1
            break
          elsif num == 2
            puts "#{@slot_money}円を返金します"
            exit
          else
            puts "1か2を入力してください"
            puts "追加で購入する：1"
            puts "払い戻す：2"
          end
        end
      else
        puts "購入可能な商品の番号を入力してください"
      end
    end
    if @juice[:stock] == 0
      puts "在庫がありません"
    else
      puts "購入金額が不足しています"
    end
    puts "#{@slot_money}円を返金します"
  end
end

vm = VendingMachine.new
vm.slot_money
vm.current_slot_money
vm.buy
