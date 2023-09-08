class Drink
  attr_accessor :name, :price, :stock
  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock 
  end
end
  $drinks = []
  $drinks << Drink.new("コーラ", 120, 5)
  $drinks << Drink.new("レッドブル", 200, 5)
  $drinks << Drink.new("水", 100, 5)

  class VendingMachine < Drink
    # ステップ０　お金の投入と払い戻しの例コード
    # ステップ１　扱えないお金の例コード
    
    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    MONEY = [10, 50, 100, 500, 1000].freeze
    
    # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
    def initialize
      # 最初の自動販売機に入っている金額は0円
      @slot_money = 0
      # @juice = {name: "コーラ", price: 120, stock: 5}
      
      @sales_money = 0

    end
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money
    @juice = $drinks
    @juices = @juice.map{|juice| juice.name}
    @prices = @juice.map{|juice| juice.price}
    @stocks = @juice.map{|juice| juice.stock}
    while true#ユーザーが購入処理or返金に移るまで繰り返す
      puts "お金を投入してください"
      money = gets.chomp.to_i
      # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
      # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      # return money unless MONEY.include?(money)
      if MONEY.include?(money)
        # 自動販売機にお金を入れる
          @slot_money += money
      else
        puts "10円玉、50円玉、100円玉、500円玉、1000円札以外は使用できません。#{money}円を返金します。"
      end
      
      puts "現在の金額は#{@slot_money}円です。投入金額は以上ですか？"
      puts "以上です：1"
      puts "追加する：2"
      puts "払い戻す：3"
      num = gets.chomp.to_i
      if num == 1 && @slot_money >= @prices.min
        return false
      elsif num == 1 && @slot_money < @prices.min
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
          if num == 1 && @slot_money >= @prices.min
            return false
          elsif num == 1 && @slot_money < @prices.min
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

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
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
    while @slot_money >= @prices.min && @stocks.min > 0
      puts "購入可能商品は以下の通り"
      puts "欲しい商品の番号を入力してください"
      @juice.each_with_index do |juice, i|
        binding.irb
        puts "番号#{i}:#{@juice[:name]}、#{@juice[:price]}円、残り#{@juice[:stock]}個"
      end
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

#   # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
#   # def return_money
#   #   # 返すお金の金額を表示する
    
#   #     puts @slot_money
#   #   # 自動販売機に入っているお金を0円に戻す
#   #   @slot_money = 0
#   # end

#   #juice = {name: "コーラ", price: 120, stock: 5} 

#   #次回やること
#   #飲み物の種類を増やす




