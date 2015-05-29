note
	description: "Thread vérifiant l'entrée au clavier afin de détecter quand quitter"
	author: "Sarah Laflamme"
	date: "$Date$"

class
	THREAD_QUITTER

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialisation

	make(a_quit_procedure:ROUTINE[ANY,TUPLE])
			-- Initialisation de `Current'. Lance la routine `a_quit_procedure'
			-- lorsque l'événement (l'entré clavier '0' est détecté) survient.
		do
			make_thread
			quit_procedure:=a_quit_procedure
		end

feature {NONE}

	execute
			-- Lecture du clavier dans un thread à part. Ce termine et exécute
			-- la routine `quit_procedure' lorsque le caractère '0' est détecté
		local
			quit:BOOLEAN
		do
			from quit:=false
			until quit
			loop
				io.read_character
				if io.last_character ='0' then
					quit:=true
					quit_procedure.call ([])
				end
			end

		end

feature {NONE} -- Implementation

	quit_procedure:ROUTINE[ANY,TUPLE]
			-- Routine à exécuter lorsque l'événement (caractère '0' dans
			-- l'entrée clavier) survient.


end
