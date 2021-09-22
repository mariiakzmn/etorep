#!/bin/bash
# 3.2

function set_path {
	PATH_TO_BIN=/ # home to bin on linux dists
	PATH_TO_PROJECT=/
}

function run_db {
	echo "bin: $PATH_TO_BIN"

	# change local path if there is need
	rm -rf /usr/local/var/postgres
	${PATH_TO_BIN}/pg_ctl stop -D /usr/local/var/postgres

	sleep 5

	${PATH_TO_BIN}/initdb -D /usr/local/var/postgres
	${PATH_TO_BIN}/pg_ctl -D /usr/local/var/postgres -l logfile start
	${PATH_TO_BIN}/createdb
	
	USER=testuser
	PASSWORD=123
	TEST_DB=test_db

	${PATH_TO_BIN}/psql -c "create user $USER with password '$PASSWORD';"
	${PATH_TO_BIN}/psql -c "create database $TEST_DB;"

	export DB_USER=$USER
	export DB_PASSWORD=$ETH
	export DB=$TEST_DB
}

function create_venv {

	current_pwd=$(pwd) 

	# create venv
	rm -rf ${PATH_TO_PROJECT}/test/testvenv
	python3 -m venv ${PATH_TO_PROJECT}/test/testvenv
	source ${PATH_TO_PROJECT}/test/testvenv/bin/activate

	# install python3 dependecies
	pip3 install -r ${PATH_TO_PROJECT}/requirements.txt
	pip3 install sqlalchemy
	pip3 install psycopg2
	pip3 install psycopg2-binary

	# set vars
	# export VAR1=123
} 

function run_prod {
	python3 ${PATH_TO_PROJECT}/test/test.py
}

function run_test_report {
	python3 ${PATH_TO_PROJECT}/test/report.py
}

# START TEST & REPORT
set_path
run_db
create_venv
run_prod
run_test_report
