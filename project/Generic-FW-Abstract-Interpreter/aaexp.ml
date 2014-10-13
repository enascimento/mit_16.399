(* aaexp.ml *)
open Abstract_Syntax   
open Pretty_Print
open Trace
(* Forward abstract interpretation of arithmetic operations *)
let rec a_aexp' a r = match a with
      | (Abstract_Syntax.NAT i) -> (Avalues.f_NAT i)
      | (VAR v)          -> (Aenv.get r v)
      | RANDOM           -> (Avalues.f_RANDOM ())
      | (UPLUS a1)       -> (Avalues.f_UPLUS (a_aexp' a1 r))
      | (UMINUS a1)      -> (Avalues.f_UMINUS (a_aexp' a1 r))
      | (PLUS (a1, a2))  -> (Avalues.f_PLUS (a_aexp' a1 r) (a_aexp' a2 r))
      | (MINUS (a1, a2)) -> (Avalues.f_MINUS (a_aexp' a1 r) (a_aexp' a2 r))
      | (TIMES (a1, a2)) -> (Avalues.f_TIMES (a_aexp' a1 r) (a_aexp' a2 r))
      | (DIV (a1, a2))   -> (Avalues.f_DIV (a_aexp' a1 r) (a_aexp' a2 r))
      | (MOD (a1, a2))   -> (Avalues.f_MOD (a_aexp' a1 r) (a_aexp' a2 r))
let do_trace_aexp a x = if trace_aexp () 
   then (print_string "Aexp["; print_Aexp a; print_string "] = "; Avalues.print x; print_newline (); x) 
   else x
let a_aexp a r =
   do_trace_aexp a (if (Aenv.is_bot r) && (Avalues.isbotempty ()) 
                    then (Avalues.bot ()) else a_aexp' a r)