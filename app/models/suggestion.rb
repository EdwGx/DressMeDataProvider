class Suggestion < ActiveRecord::Base
    enum response: [:very_negative, :negative, :skip, :positive, :very_positive]
    has_and_belongs_to_many :clothes
    belongs_to :situation

    def update_response(r)
        self.response = r
        sc = 0
        case self.response.to_sym
        when :very_negative
            sc = -5
        when :negative
            sc = -3
        when :skip
            sc = -1
        when :positive
            sc = 3
        when :very_positive
            sc = 5
        end

        self.clothes.each do |c|
            c.score = c.score + sc
            c.save!

            c.article.score = c.article.score + sc
            c.article.save!

            c.color.score = c.color.score + sc
            c.color.save!

            ats = ArticleToSituation.find_or_create_by(article: c.article, situation: self.situation)
            ats.score += sc
            ats.save

            cts = ColorToSituation.find_or_create_by(color: c.color, situation: self.situation)
            cts.score += sc
            cts.save

            c.tags.each do |t|
                tts = TagToSituation.find_or_create_by(tag: t, situation: self.situation)
                tts.score += sc
                tts.save
            end
        end

        comb = Combination.find_by(khash: self.clothes.map { |e| e.article_id }.sort.map(&:to_s).join("-"))
        if comb.nil?
            comb = Combination.create
            comb.articles << self.clothes.map { |e| e.article }
        end
        comb.score += sc
        comb.save

        cos = CombinationToSituation.find_or_create_by(combination: comb, situation: situation)
        cos.score += sc
        cos.save

        self.save
    end

    def good_for_situation(text)
        situation = Situation.find_or_create_by(name: text)
        self.situation = situation
        self.response = :very_positive
        sc = 5

        self.clothes.each do |c|

            ats = ArticleToSituation.find_or_create_by(article: c.article, situation: self.situation)
            ats.score += sc
            ats.save

            cts = ColorToSituation.find_or_create_by(color: c.color, situation: self.situation)
            cts.score += sc
            cts.save

            c.tags.each do |t|
                tts = TagToSituation.find_or_create_by(tag: t, situation: self.situation)
                tts.score += sc
                tts.save
            end
        end

        comb = Combination.find_by(khash: self.clothes.map { |e| e.article_id }.sort.map(&:to_s).join("-"))
        if comb.nil?
            comb = Combination.create
            comb.articles << self.clothes.map { |e| e.article }
        end
        comb.score += sc
        comb.save

        cos = CombinationToSituation.find_or_create_by(combination: comb, situation: situation)
        cos.score += sc
        cos.save

        self.save
    end
end
