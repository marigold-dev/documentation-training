.PHONY: all build doc clean deps dev-deps fmt test

all: doc

build:
	dune build

doc: build
	dune build @doc

clean:
	dune clean

deps:
	opam install . --deps-only --with-doc --with-test -y

dev-deps:
	opam install dune merlin ocamlformat ocp-indent utop -y

fmt:
	dune build @fmt --auto-promote

test:
	dune runtest --no-buffer -j 1
