(* red-ISS-Intervals23.ml *)
open Avalues2 (* avalues.ml of Initialization-Simple-Sign *)
(* \gamma(BOT)  = {_O_(a)}                                       *)
(* \gamma(NEG)  = [min_int,-1] U {_O_(a)}                        *)
(* \gamma(POS)  = [1,max_int] U {_O_(a)}                         *)
(* \gamma(ZERO) = {0, _O_(a)}                                    *)
(* \gamma(INI)  = [min_int,max_int] U {_O_(a)}                   *)
(* \gamma(ERR)  = {_O_(a),_O_(i)}                                *)
(* \gamma(TOP)  = [min_int,max_int] U {_O_(a),_O_(i)}            *)
open Avalues3 (* avalues.ml of Intervals *)
(* gamma (a,b) = [a,b] U {_O_(a), _O_(i)} when min_int <= a <= b <= max_int *)
(*             = {_O_(a), _O_(i)}         when a = max_int > min_int = b    *)
let gamma12 a = 
   if (Avalues2.eq a (Avalues2.bot ())) then (Avalues3.bot ())
   else if (Avalues2.eq a (Avalues2.f_UMINUS (Avalues2.f_NAT "1"))) then (Avalues3.neg ())
   else if (Avalues2.eq a (Avalues2.f_NAT "0")) then (Avalues3.f_NAT "0")
   else if (Avalues2.eq a (Avalues2.f_NAT "1")) then (Avalues3.pos ())
   else (Avalues3.top ()) 
let alpha21 i =
   if (Avalues3.eq i (Avalues3.bot ())) then (Avalues2.initerr ())
   else if ((sign i) = -1) then (Avalues2.f_UMINUS (Avalues2.f_NAT "1"))
   else if ((sign i) = 0) then (Avalues2.f_NAT "0")
   else if ((sign i) = 1) then (Avalues2.f_NAT "1")
   else (Avalues2.top ())
let reduce (a, b) = (Avalues2.meet a (alpha21 b), Avalues3.meet b (gamma12 a))