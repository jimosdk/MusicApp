module ApplicationHelper

    def auth_token
        "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\"/>".html_safe
    end

    def ugly_lyrics(lyrics)
        chunks = chunks(lyrics)
        html = '<pre>' + chunks.join + '</pre>'
        html.html_safe
    end

    private

    def chunks(lyrics)
        temp = []
        prev_char = nil
        arr = lyrics.chars.each_with_object([]) do |char,arr|
            next temp << " " if char == "\n" || char == "\r" 
            temp << char
            if temp.length >= 40 && (char == ' ' || char == ',')
                arr << '♫ ' + h(temp.join('')) + '<br>'
                temp = []
            end
        end
        arr << '♫ ' + h(temp.join(''))+ '<br>'
    end
    
end
