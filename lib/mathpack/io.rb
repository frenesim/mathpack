module Mathpack
  module IO
    def self.print_table_function(params = {})
      fail 'Arrays length dismatch' if params[:x].length != params[:y].length
      File.open(params[:filename] || 'table_function.csv', 'w+') do |file|
        file.write("#{params[:labels][:x]};#{params[:labels][:y]}\n") if params[:labels] && params[:labels][:x] && params[:labels][:y]
        params[:x].each_index do |i|
          file.write("#{params[:x][i]};#{params[:y][i]}\n")
        end
      end
    end
  end
end
