import tkinter as tk
window = tk.Tk()

greeting = tk.Label(text = "Hello peasants")

run_button = tk.Button(

    text = "Run",
    width = 20,

)

run_button.pack()
greeting.pack()

window.mainloop()



