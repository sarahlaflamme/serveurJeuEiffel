note
	description: "Thread v�rifiant l'entr�e au clavier afin de d�tecter quand quitter"
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
			-- lorsque l'�v�nement (l'entr� clavier '0' est d�tect�) survient.
		do
			make_thread
			quit_procedure:=a_quit_procedure
		end

feature {NONE}

	execute
			-- Lecture du clavier dans un thread � part. Ce termine et ex�cute
			-- la routine `quit_procedure' lorsque le caract�re '0' est d�tect�
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
			-- Routine � ex�cuter lorsque l'�v�nement (caract�re '0' dans
			-- l'entr�e clavier) survient.


end
