def getValue(hand)
    hand = hand.split("")

    hand.each_with_index do |card, index|
        if card == "T"
            hand[index] = "10"
        elsif card == "J"
            hand[index] = "01" # joker has lowest value of any card
        elsif card == "Q"
            hand[index] = "12"
        elsif card == "K"
            hand[index] = "13"
        elsif card == "A"
            hand[index] = "14"
        else
            hand[index] = "0"+card
        end

    end
    return hand.join("").to_i

end

def findBestHandWithJoker(hand)    
    mostCommonCard = hand.chars
    .reject { |char| char == 'J' } # Reject 'J' and 'j'
    .group_by { |char| char }
    .transform_values(&:count)
    .max_by { |char, count| count }

    if mostCommonCard == nil
        mostCommonCard = "J"
    end

    hand = hand.gsub("J", mostCommonCard[0])

    return hand

    
end

def getHandType(hand)
    if hand.include? "J"
        hand = findBestHandWithJoker(hand)
    end

    sorted = hand.split("").sort.join("")
    isFiveOfAKind = /([2-9TJQKA])\1{4}/.match(sorted)
    isFourOfAKind = /([2-9TJQKA])\1{3}/.match(sorted)
    isFullHouse = /([2-9TJQKA])\1{2}([2-9TJQKA])\2{1}/.match(sorted) || /([2-9TJQKA])\1{1}([2-9TJQKA])\2{2}/.match(sorted)
    isThreeOfAKind = /([2-9TJQKA])\1{2}/.match(sorted)
    isTwoPair = /([2-9TJQKA])\1.*([2-9TJQKA])\2/.match(sorted)
    isPair = /([2-9TJQKA])\1/.match(sorted)


    if isFiveOfAKind
        return "Five of a Kind"
    end

    if isFourOfAKind
        return "Four of a Kind"
    end

    if isFullHouse
        return "Full House"
    end

    if isThreeOfAKind
        return "Three of a Kind"
    end

    if isTwoPair
        return "Two Pair"
    end

    if isPair
        return "Pair"
    end

    return "High Card"
end

def getHandTypeValue(handType)
    case handType
    when "Five of a Kind"
        return 60000000000
    when "Four of a Kind"
        return 50000000000
    when "Full House"
        return 40000000000
    when "Three of a Kind"
        return 30000000000
    when "Two Pair"
        return 20000000000
    when "Pair"
        return 10000000000
    when "High Card"
        return 0
    end
end

list = []

File.open("input.txt", "r") do |file|
    file.each_line do |line|
        hand = line.split(" ")[0]
        bet = line.split(" ")[1]
        list.push({:hand => hand, :bet => bet, :value => getValue(hand), :type => getHandType(hand)})
    end
end

list.each do |item|
    item[:value] = item[:value] + getHandTypeValue(item[:type])
end

list = list.sort_by { |item| item[:value] }

puts list

sum = 0
list.each_with_index do |item, index|
    # puts "rank: #{index+1} -> #{item[:bet].to_i * (index + 1)} for bet #{item[:bet]}"
    sum += item[:bet].to_i * (index + 1)
end

puts sum
