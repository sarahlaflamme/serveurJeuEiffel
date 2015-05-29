note
	description: "Affiche un message � r�p�tition dans un thread secondaire"
	author: "Louis Marchand"
	date: "2015, Febuary 18"
	revision: "1.0"

class
	EX_THREAD

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make (chaine: STRING)
			-- Initialisation de `Current' utilisant `chaine' comme message
			-- � afficher lors de l'ex�cution.
		do
			make_thread
			must_stop := false
			chaine_affiche := chaine
		end

feature -- Access

	stop_thread
			-- Arr�ter l'ex�cution du thread de `Current'
		do
			must_stop := true
		end

feature {NONE} -- Thread methods

	execute
			-- Ex�cution (thread) de `Current'
		do
			from
			until
				must_stop
			loop
				io.put_string (chaine_affiche)
				io.output.flush
			end
		end

feature {NONE} -- Implementation

	must_stop: BOOLEAN
			-- Vrai si `Current' doit terminer son ex�cution

	chaine_affiche: STRING
			-- Chaine � afficher en boucle lors de l'ex�cution de `Current'

end
