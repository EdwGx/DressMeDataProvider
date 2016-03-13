class PagesController < ApplicationController
    def parse_clothes
        text = params[:text]

        render json: Clothe.prase_and_add(text)
    end

    def get_random_clothes
        arr = Clothe.get_random_clothes
        s = Suggestion.create
        s.clothes << arr
        s.save
        render json: arr.map { |e| e.short_description }
    end

    def response_suggestion
        if suggestion = Suggestion.where.not(situation_id: nil).order(created_at: :DESC).first
            suggestion.update_response(params[:text])
            render plain: "OK"
        else
            render plain: "ERR"
        end
    end

    def give_suggestion
        text = params[:text] || "casual"
        cs = Clothe.give_suggestion(text)
        s = Suggestion.create
        s.clothes << cs
        s.save
        render json: cs.map { |e| e.short_description }
    end

    def good_for_situation
        if suggestion = Suggestion.order(created_at: :DESC).first
            suggestion.good_for_situation(params[:text])
            render plain: "OK"
        else
            render plain: "ERR"
        end
    end
end
