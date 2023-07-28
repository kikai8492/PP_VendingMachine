class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    puts "合計金額は#{@slot_money}円です。"
    puts "購入に移る：1"
    puts "取りやめる：2"
    while true
      num = gets.chomp.to_i
      if num == 1
        return "購入の処理に続く"
      elsif num == 2
        return @slot_money
      else
        puts "1か2を入力してください"
        puts "購入に移る：1"
        puts "取りやめる：2"
      end
    end
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    # return money unless MONEY.include?(money)
    if MONEY.include?(money)
    # 自動販売機にお金を入れる
      @slot_money += money
    else
      if money == 0
        puts "10円玉、50円玉、100円玉、500円玉、1000円札以外は使用できません。"
      else
        puts "10円玉、50円玉、100円玉、500円玉、1000円札以外は使用できません。"
        return money
      end
    end
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    
      puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
end

class MoneySlotting
  def self.money_slotting
    @vm = VendingMachine.new
    while true#ユーザーが購入処理or返金に移るまで繰り返す
      puts "金入れろ"
      @vm.slot_money(gets.chomp.to_i)
      puts "投入金額は以上ですか？"
      puts "以上です：1"
      puts "追加する：2"
      num = gets.chomp.to_i
      if num == 1
        return false
      elsif num == 2
        true
      else
        puts "1か2を入力してください"
        puts "以上です：1"
        puts "追加する：2"
      end
    end

    def self.sum_of_slot_maney
      @vm.current_slot_money
    end

  end
  # vm.slot_money(1000)
  # vm.slot_money(1)
  # puts vm.current_slot_money
end

MoneySlotting.money_slotting
MoneySlotting.sum_of_slot_maney


# puts VendingMachine.new.current_slot_money


