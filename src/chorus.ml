exception
  Firstname_too_short of {
    firstname : string;
    expected_minimal_size : int;
    given_size : int;
  }

exception
  Lastname_too_short of {
    lastname : string;
    expected_minimal_size : int;
    given_size : int;
  }

let hello_world () = print_endline "Hello World!"

let say_hello firstname lastname =
  let firstname_length = String.length firstname in
  if firstname_length < 2 then
    raise
      (Firstname_too_short
         { firstname; expected_minimal_size = 2; given_size = firstname_length });
  let lastname_length = String.length lastname in
  if lastname_length < 1 then
    raise
      (Lastname_too_short
         { lastname; expected_minimal_size = 1; given_size = lastname_length });
  let firstname = String.capitalize_ascii firstname
  and lastname = String.capitalize_ascii lastname in
  let name = firstname ^ " " ^ lastname in
  let message = "Hello " ^ name in
  print_endline message
