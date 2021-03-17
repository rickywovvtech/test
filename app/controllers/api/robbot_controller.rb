class Api::RobbotController < ApplicationController
    skip_before_action :verify_authenticity_token
    def test
        # test
        render json: {status: "testing commenting"}
    end

    def create
        moves = params[:commands]
        place = false
        x = false
        y = false
        report = false
        direction = false
        data = "#{x},#{y},#{direction}"
        moves.each do |move|
            if move[0..4]=="PLACE"
                place = move[0..4]
                x = move[6]
                x="#{x}"
                x=x.to_i
                y = move[8]
                y = "#{y}"
                y = y.to_i
                direction = move[10..15]
            end
            if move=="REPORT"
                report = "REPORT"
            end
            if (place=="PLACE" && ((x<5).present? && (x>-1).present?) && ((y<5).present? && (y>-1).present?))
                if direction=="NORTH"
                    if move=="MOVE"
                        if y<4
                            y = y+1
                        end
                    elsif move=="LEFT"
                        direction = "WEST"
                    elsif move=="RIGHT"
                        direction = "EAST"
                    end
                elsif direction=="SOUTH"
                        if move=="MOVE"
                            if y>0
                                y = y-1
                            end
                        elsif move=="LEFT"
                            direction = "EAST"
                        elsif move=="RIGHT"
                            direction = "WEST"
                        end
                elsif direction=="EAST"
                        if move=="MOVE"
                            if x<4
                                x = x+1
                            end
                        elsif move=="LEFT"
                            direction = "NORTH"
                        elsif move=="RIGHT"
                            direction = "SOUTH"
                        end
                elsif direction=="WEST"
                        if move=="MOVE"
                            if x>0
                                x = x-1
                            end
                        elsif move=="LEFT"
                            direction = "SOUTH"
                        elsif move=="RIGHT"
                            direction = "NORTH"
                        end
                end
            end
        end
        data = "#{x},#{y},#{direction}"
        if (place=="PLACE" && ((x<5).present? && (x>-1).present?) && ((y<5).present? && (y>-1).present?))
        #   if report =="REPORT"
            render json: {location: data}
        #   else
        #     render json: {status: "REPORT not requested"}
        #   end
        elsif place=="PLACE" && x.present? && y.present?
            render json: {status: "Wrong origin"}
        elsif place=="PLACE"
            render json: {status: "Origin not found"}
        end
    end
end
