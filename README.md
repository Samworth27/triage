## T1A3 - Terminal Project
# Dynamic Queue System

This is a system designed to manage a tickted queue where queue items are prioritised by the user. 
It currently can be run as a standalone system or using a server to manage the queue and multiple clients that are able to add items to the queue and request the next queue item 



▒█▀▀▄ █░░█ █▀▀▄ █▀▀█ ▒█▀▀█ █░░█ █▀▀ █░░█ █▀▀   
▒█░▒█ █▄▄█ █░░█ █▄▄█ ▒█░▒█ █░░█ █▀▀ █░░█ █▀▀   
▒█▄▄▀ ▄▄▄█ ▀░░▀ ▀░░▀ ░▀▀█▄ ░▀▀▀ ▀▀▀ ░▀▀▀ ▀▀▀  
  

## How to use
### Modes
 - `ruby triage.rb --local` This will run the DynaQueue system locally in one terminal. You can run many instances of this but they will not be able to interact with one another
 - `ruby triage.rb --server` This will run the DynaQueue server in the terminal. Only run one instance of this.
 - `ruby triage.rb --client` This will run the DynaQueue client in the terminal. You can run many instances of this.
Using `--admin` in addition will allow you to run database management before running the software in your chosen mode
Using `--testing` will remove all prompts when creating queue items and will populate some data for the items randomly


### Related links
[Project Board](https://github.com/users/Samworth27/projects/2)  
[RSPEC Testing Reports](https://samworth27.github.io/triage/reports/overview.html)

![Project Boards](./docs/project.png)
![Testing](./docs/testing.png)
