# frozen_literal_string: true

# Load all children
Dir.glob(File.expand_path("../#{File.basename(__FILE__, ".*")}/*.rb", __FILE__)).each { |file| require_relative "#{File.basename(__FILE__, ".*")}/#{File.basename(file)}"}

# https://browser.icpc-3.info/browse.php?operation=search1&str=common%20cold
module SymptomSearch
  def search
    prompt = TTY::Prompt.new(active_color: :inverse)

    ### Display Search Results
    input = fetch_search(prompt.ask("Enter search term > "))
    input[:children].map! { |child| child[:id]}
    input[:code] = 'Search Results'

    loop do
      display = pretty(input.clone)
      clear_screen
      puts display[:string].render(:unicode, resize: true, height: 6, alignments: [:right, :left],column_widths: [15,TTY::Screen.width-15])
      
      choices = display[:children]

      choices.append([
        {value: 'search', name: Rainbow('>> Return to Search').red},
        {value:'exit', name: Rainbow('>> Exit without selecting an option').red}
        ]
      )
      options = prompt.select("Choose an item, return to the previous item, restart or exit",choices, filter: true, per_page:(TTY::Screen.height-6))
      case options
      when 'exit'
        return :exit
      when 'search'
        return search
      else
        display = fetch_pretty(options)
        clear_screen
        puts display[:string].render(:unicode, resize: true, height: 6, alignments: [:right, :left],column_widths: [15,TTY::Screen.width-15])
        if display[:children].size.zero?
          # End of branch options
          choices = [
            {value: 'select', name: 'Select option'},
            {value: 'rubric', name: 'Fetch rubric', disabled: '(Feature not complete)'},
            {value: 'return', name: 'Return to search'}
          ]
          case prompt.select("Choose an option", choices)
        
          when 'select'
            return display[:code]
          when 'rubric'
            puts 'Fetching rubric'
            prompt.keypress("Press any key to continue")
            clear_screen
            redo
          else
            redo
          end
        end
      end
    end 
  end
end