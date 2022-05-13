(* ::Package:: *)

(* ::Title:: *)
(*xTerior*)


(* ::Subtitle:: *)
(*Exterior Calculus for xAct*)


(* ::Subsubtitle:: *)
(*Alfonso Garc\[IAcute]a-Parrado*)
(*agparrado@uco.es*)
(*Universidad de C\[OAcute]rdoba, Spain*)
(**)
(*Leo C. Stein*)
(*leo.stein@gmail.com*)
(*U of MS, MS, United States*)
(**)
(*(c) 2013-2019, under GPL*)
(**)
(*http://www.xAct.es/*)
(*http://groups.google.com/group/xAct*)
(*https://github.com/xAct-contrib*)


(* ::Text:: *)
(*xTerior is a package for exterior calculus in xAct.*)
(**)
(*xTerior is distributed under the GNU General Public License, and runs on top of xTensor and xCoba which are free packages for fast manipulation of abstract and component tensor expressions. All packages can be downloaded from http://www.xact.es/*)


(* ::Input:: *)
(*DateList[]*)


(* ::Input::Initialization:: *)
xAct`xTerior`$xTensorVersionExpected={"1.1.2",{2015,8,23}};
xAct`xTerior`$Version={"0.9.1",{2019,5,17}};


(* ::Subsection::RGBColor[0, 0, 1]:: *)
(*1. Initialization*)


(* ::Subsubsection:: *)
(*1.0. TODO list*)


(* ::Text:: *)
(*TODO : *)
(*-Add some option to DefDiffForm which allows the user to include the degree in the printing output.*)
(*-In the definition of the connection forms there are no checks about the manifolds in which the covariant derivatives are defined and they may well be defined in different tangent bundles.*)
(*-ContractBasis and ToBasis commute with the exterior derivative. Implement it. This is partially done.*)


(* ::Input:: *)
(*Diff[FBasis[{1},B],cd]*)


(* ::Text:: *)
(*There's a bug here, this should have expressed the exterior covariant derivative in terms of the usual exterior derivative.*)


(* ::Input:: *)
(*ChangeExtD[%,cd,PD]*)


(* ::Subsubsection::Closed:: *)
(*1.1. GPL*)


(* ::Input::Initialization:: *)
(* xTerior: exterior calculus in Differential Geometry *)

(* Copyright (C) 2013 Alfonso Garcia-Parrado Gomez-Lobo and Leo C. Stein *)

(* This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License,or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place-Suite 330, Boston, MA 02111-1307, USA. 
*)


(* ::Subsubsection::Closed:: *)
(*1.2. Info package*)


(* ::Input::Initialization:: *)
(* :Title: xTerior *)

(* :Author: Alfonso Garcia-Parrado Gomez-Lobo and Leo C. Stein *)

(* :Summary: exterior calculus in Differential Geometry *)

(* :Brief Discussion:
   - xTerior extends xAct to work with differentiable forms in general manifolds.
   - Introduces the exterior algebra, the exterior derivative, the Hodge dual, the connection and curvature forms for an arbitrary connection, the exterior covariant derivative.
   
*)
  
(* :Context: xAct`xTerior` *)

(* :Package Version: 0.9.1 *)

(* :Copyright: Alfonso Garcia-Parrado Gomez-Lobo and Leo C. Stein (2013) *)

(* :History: See xTerior.History *)

(* :Keywords: *)

(* :Source: xTerior.nb *)

(* :Warning: *)

(* :Mathematica Version: 9.0 and later *)

(* :Limitations:
	- ?? *)


(* ::Subsubsection::Closed:: *)
(*1.3. BeginPackage*)


(* ::Input::Initialization:: *)
With[{xAct`xTerior`Private`xTeriorSymbols=DeleteCases[Join[Names["xAct`xTerior`*"],Names["xAct`xTerior`Private`*"]],"$Version"|"xAct`xTerior`$Version"|"$xTensorVersionExpected"|"xAct`xTerior`$xTensorVersionExpected"]},
Unprotect/@xAct`xTerior`Private`xTeriorSymbols;
Clear/@xAct`xTerior`Private`xTeriorSymbols;
]


(* ::Input::Initialization:: *)
If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`xTerior`"];


(* ::Input:: *)
(*xAct`xCore`Private`$LastPackage*)


(* ::Text:: *)
(*Explicit (not hidden) import of xTensor, xPerm and xCore: Alfonso: do we need xCoba ?*)


(* ::Input::Initialization:: *)
BeginPackage["xAct`xTerior`",{"xAct`xCoba`","xAct`xTensor`","xAct`xPerm`","xAct`xCore`"}]


(* ::Input::Initialization:: *)
If[Not@OrderedQ@Map[Last,{xAct`xTerior`$xTensorVersionExpected,xAct`xTensor`$Version}],Throw@Message[General::versions,"xTensor",xAct`xTensor`$Version,xAct`xTerior`$xTensorVersionExpected]]


(* ::Input::Initialization:: *)
Print[xAct`xCore`Private`bars]
Print["Package xAct`xTerior`  version ",xAct`xTerior`$Version[[1]],", ",xAct`xTerior`$Version[[2]]];
Print["CopyRight (C) 2013, Alfonso Garcia-Parrado Gomez-Lobo and Leo C. Stein, under the General Public License."];


(* ::Text:: *)
(*We specify the context xAct`xTerior` to avoid overriding the Disclaimer of the other packages. However we need to turn off the message General:shdw temporarily:*)


(* ::Input::Initialization:: *)
Off[General::shdw]
xAct`xTerior`Disclaimer[]:=Print["These are points 11 and 12 of the General Public License:\n\nBECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM `AS IS\.b4 WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.\n\nIN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES."]
On[General::shdw]


(* ::Text:: *)
(*If xTerior is not being called from other package then write this GPL short disclaimer:*)


(* ::Input::Initialization:: *)
If[xAct`xCore`Private`$LastPackage==="xAct`xTerior`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]]


(* ::Text:: *)
(*Note that symbols in the Global` context cannot be accessed right now.*)


(* ::Input:: *)
(*$ContextPath*)


(* ::Input:: *)
(*$Context*)


(* ::Text:: *)
(*Established connection to external executable?*)


(* ::Input:: *)
(*$xpermQ*)


(* ::Text:: *)
(*Private functions of xTensor used here :*)
(*      ??*)


(* ::Subsubsection::Closed:: *)
(*1.4. Non-standard setup*)


(* ::Text:: *)
(*Screen all dollar indices:*)


(* ::Input::Initialization:: *)
$PrePrint=ScreenDollarIndices;


(* ::Text:: *)
(*Switch off messages issued by ManifoldOfCovD acting on PD.*)


(* ::Input::Initialization:: *)
Unprotect@PD;
PD/:ManifoldOfCovD@PD=.
Protect@PD;


(* ::Text:: *)
(*Timings will be shown if they are above 1 Second (Only for this notebook; this is not included in the package):*)


(* ::Input:: *)
(*<<xAct/ShowTime1.m*)


(* ::Input:: *)
(*$ShowTimeThreshold*)


(* ::Text:: *)
(*We also read the package (this is not automatic in xCore anymore since its version 0.6.2). This is not included in the package.*)


(* ::Input:: *)
(*<<xAct/ExpressionManipulation.m*)


(* ::Subsubsection::Closed:: *)
(*1.5. Usage messages *)


(* ::Input::Initialization:: *)
(* Definition and undefinition of a differential form (just a wrapper for DefTensor with the option GradeOfTensor\[Rule]{Wedge})*)
DefDiffForm::usage="DefDiffForm[form[inds], mani, Deg] defines a tensor valued differential form of degree deg on the manifold mani";
UndefDiffForm::usage="UndefDiffForm[form] undefines the differential form form";
(* Grade of a differential form *)
Deg::usage="Deg[form] returns the grade of a differential form";
DiffFormQ::usage="DiffFormQ is an option for LieToCovD which specifies whether the expression which is acted upon should be regarded as a differential form or not. This is an option added by xTerior and it is not present any other package using LieToCovD.";
(* Exterior derivative and exterior covariant derivative *)
Diff::usage="Diff[form] computes the exterior derivative of form. Diff[form,covd] computes the exterior covariant derivative of form with respect to the covariant derivative covd.";
FindPotential::usage="FindPotential[form, point, chart] uses the Poincar\[EAcute] lemma to compute a potential for a closed form form (no checks are carried out to ensure that the form is actually closed). The form must be written in some explicit coordinates belonging to chart and the argument point is the point, assumed to be in the same coordinate chart as form, which defines a star-shaped region where the potential is differentiable. A change in the point will give in general a different potential";
(* Computation of the exterior covariant derivative *)
ChangeExtD::usage="ChangeExtD[expr,cd1,cd2] expresses the exterior covariant derivative taken with respect to the connection defined by the covariant derivative cd1 in terms of the exterior covariant derivative taken with respect to the connection defined by the covariant derivative cd2";
(* Hodge dual *)
Hodge::usage="Hodge[metric][expr] is the Hodge dual of expr defined with respect to metric";
ExpandHodgeDual::usage="ExpandHodgeDual[expr,Coframe[mani],g] expands out all the Hodge duals of the exterior powers of Coframe[mani], defined with respect to the metric g. If the manifold tag mani is dropped, then all the instances of Coframe are expanded. The Coframe label can be replaced by dx if we are using the holonomic coframe.";
(* Co-differential *)
Codiff::usage="Codiff[metric][form] is the co-differential of form computed with respect to metric";
(* Expansion of the co-differential *)
CodiffToDiff::usage="CodiffToDiff[expr] replaces all the instances of the co-differential in expr by their expansion in terms of the exterior derivative.";
(* Interior contraction *)
Int::usage="Int[v][form] is the interior contraction of form with the vector (rank 1-tensor) v";
(* Lie derivative on forms *)
CartanD::usage="CartanD[v][form] is the Cartan derivative of form with respect to the vector (rank 1-tensor) v. CartanD[v][form,covd] is the Cartan derivative with respect to the covariant derivative covd.";
(* Cartan formula for Lie derivatives *)
CartanDToDiff::usage="CartanDToDiff[expr] replaces the Cartan derivative of all the differential forms in expr by their expansion obtained by means of the Cartan formula";
(* Put derivations into canonical order *)
SortDerivations::usage="SortDerivations[expr] brings expr into a new expression where all the derivations (exterior derivative, Lie derivative and interior contraction) are written in a canonical order. The default left-to-right order is defined by the variable $DerivationSortOrder";
$DerivationSortOrder::usage="$DerivationSortOrder is a global variable which encodes the default ordering of the three derivatives Int, LieD and Diff. The default is {LieD,Int,Diff}";
(* Variational derivative on forms *)
FormVarD::usage="FormVarD[form,metric][expr] computes the variational derivative of expr, which must be a n-form with n the manifold dimension, with respect to form. In the computation, exterior derivatives are transformed into co-differentials taken with respect of metric.";
(* Canonical forms on the frame bundle *)
Coframe::usage="Coframe[mani] is the set of canonical 1-forms defined in the frame bundle arising from the manifold mani";
dx::usage="dx[mani] represents a holonomic co-frame in the manifold mani.";
(* The connection 1-form *)
ConnectionForm::usage="ConnectionForm[cd,vbundle] represents the connection 1-form associated to the covariant derivatives cd defined in the bundle vbundle. If vbundle is the tangent bundle of a differentiable manifold then ConnectionForm is automatically replaced by ChristoffelForm (see the on-line help of ChristoffelForm for further details).";
(* The curvature 2-form *)
CurvatureForm::usage="CurvatureForm[cd,vbundle] represents the curvature 2-form associated to the covariant derivative cd. If vbundle is the tangent bundle of a differentiable manifold then CurvatureForm is replaced by RiemannForm";
(* Connection 2-form for a connection in a frame bundle*)
ChristoffelForm::usage="ChristoffelForm[cd] is the connection 1-form associated to the covariant derivative cd which is a covariant derivative in the tangent bundle of a manifold";
(* Curvature 2-form for a connection in a frame bundle *)
RiemannForm::usage="RiemannForm[cd] is the curvature 2-form associated to the covariant derivative cd which is a covariant derivative in the frame bundle of a manifold";
(* Transformation of the connection form to the connection tensor *)
ConnectionFormToTensor::usage="ConnectionFormToTensor[expr,covd,frame] transforms all instances of the connection form into the (A)Christoffel tensor which relates the covariant derivative defining the connection form and covd. The variable frame can take the value of either Coframe or dx. If the (A)Christoffel tensor does not exist it is created automatically.";
CurvatureFormToTensor::usage="CurvatureFormToTensor[expr,frame] transforms all the instances of the curvature form into the related Riemann or FRiemann tensor, inserting the corresponding frame (either Coframe or dx).";
ChangeCurvatureForm::usage="ChangeCurvatureForm[curvature,cd1,cd2] writes the curvature 2-form curvature[cd1,vbundle] in terms of the curvature 2-form curvature[cd2,vbundle]";
(* The torsion 2-form *)
TorsionForm::usage="TorsionForm[cd] represents the torsion 2-form arising from the covariant derivative cd (cd must be defined on the tangent bundle of a manifold)";
(* Cartan structure equations *)
UseCartan::usage="UseCartan[expr,covd] expands all the instances of the Diff using the Cartan structure equations for the connection arising from covd. In this way it is possible to expand the exterior derivative of a co-frame, a torsion 2-form and the curvature 2-form. If covd is the Levi-Civita connection of a metric, then the exterior derivatives of that metric and its volume element are expanded too. UseCartan[expr,PD] expands all instances of the exterior derivative in terms of partial derivatives defined in the list of manifolds returned by ManifoldsOf[expr]. It is possible to specify a custom list of manifolds as a third argument in the form UseCartan[expr,PD,{M1,M2,..}]";
(* Zero forms *)
ZeroDegQ::usage="ZeroDegQ[expr] returns True if the degree of expr is zero";
UseDimensionStart::usage="UseDimensionStart[] is an instruction that, when issued, makes any expression with degree greater than the manifold dimension equal to zero.";
UseDimensionStop::usage="UseDimensionStop[] cancels the action of UseDimensionStart[]";
(* Integration of differential forms over manifolds with boundary *)
FormIntegrate::usage="FormIntegrate[form, M] represents the integration of the given differential form, of degree n, over the n-dimensional manifold M with boundary.";
UseStokes::usage="UseStokes[expr, M] converts subexpressions FormIntegrate[Diff[form], M] in expr into FormIntegrate[form, ManifoldBoundary[M]], reducing n-dimensional integration to (n-1)-integration. UseStokes[expr, form] converts subexpressions FormIntegrate[form, ManifoldBoundary[M]] in expr into FormIntegrate[Diff[form], M]. UseStokes[expr] performs UseStokes[expr, M] wherever possible in expr, to reduce dimensionality of integration.";


(* ::Subsubsection::Closed:: *)
(*1.6. Begin private*)


(* ::Input::Initialization:: *)
Begin["`Private`"]


(* ::Text:: *)
(*There are ?? reserved words in version 0.8.5 :*)


(* ::Input:: *)
(*Names["xAct`xTerior`*"]*)


(* ::Input:: *)
(*%//Length*)


(* ::Input::Initialization:: *)
$ContextPath


(* ::Input:: *)
(*$Context*)


(* ::Input:: *)
(*%*)


(* ::Subsection::RGBColor[0, 0, 1]:: *)
(*2. Basic structures*)


(* ::Subsubsection::Closed:: *)
(*2.1 Definition of the wedge product*)


(* ::Text:: *)
(*The wedge product is an associative, anticommutative (actually supercommutative) graded product with identity 1. The scalars are those objects of grade 0, including the identity 1, so that the scalars are actually in this case true elements of the algebra. The product by scalar and the product of scalars are both Times, so we do not need to specify them.*)


(* ::Input::Initialization:: *)
DefProduct[Wedge,
AssociativeProductQ->True,
CommutativityOfProduct->"SuperCommutative",
GradedProductQ->True,
IdentityElementOfProduct->1,
ScalarsOfProduct->(SameQ[Grade[#,Wedge],0]&),
DefInfo->Null
];


(* ::Text:: *)
(*Relation between Wedge and Times.*)


(* ::Input::Initialization:: *)
Wedge/:GradeOfProduct[Times,Wedge]=0;


(* ::Text:: *)
(*When working with the exterior algebra the grade is typically called degree:*)


(* ::Input::Initialization:: *)
Deg[expr_]:=Grade[expr,Wedge];


(* ::Text:: *)
(*Scalars have zero degree:*)


(* ::Input:: *)
(*Deg[2]*)


(* ::Text:: *)
(*A product of scalars is automatically converted into a scalar:*)


(* ::Input:: *)
(*1\[Wedge]2\[Wedge]3*)


(* ::Text:: *)
(*The wedge product is eliminated when found with only one argument:*)


(* ::Input:: *)
(*Wedge[a]//FullForm*)


(* ::Text:: *)
(*Note that parentheses are needed sometimes. Compare*)


(* ::Input:: *)
(*{Hold[(a\[Wedge]3)b],Hold[a\[Wedge](3b)]}*)


(* ::Input:: *)
(*%//FullForm*)


(* ::Text:: *)
(*Behavior of the wedge product with respect to Dagger*)


(* ::Input::Initialization:: *)
Unprotect@Dagger;
Dagger@expr_Wedge:=Dagger/@expr;
Protect@Dagger;


(* ::Text:: *)
(*Behavior of the wedge product with respect to CTensor (perhaps this should be in xCoba). *)


(* ::Text:: *)
(*Vanishing of forms whose degree is higher than the manifold(s) dimension.*)


(* ::Input::Initialization:: *)
(*Code added by Jos\[EAcute]*)
$UseDimensionsQ=False;

$DimensionsZeroForms={};
SetZeroForm[form_]:=If[GradeOfTensor[form,Wedge]>Plus@@(DimOfManifold/@DependenciesOfTensor[form]),form[___]=0;AppendTo[$DimensionsZeroForms,form]];
UnsetZeroForm[form_]:=Unset[form[___]];


UseDimensionStart[]:=Module[{},If[$UseDimensionsQ,Return[]];
$UseDimensionsQ=True;
(*Forms whose degree is greater than the dimension*)SetZeroForm/@$Tensors;
(*Expressions which are wedge products*)HoldPattern@Wedge[expr__]:=0/;(Plus@@(Grade[#,Wedge]&/@{expr})>(Plus@@(DimOfManifold/@Union@Flatten[DependenciesOf/@{expr}])));
(*Expressions which are exterior derivatives*)HoldPattern@Diff[expr_,PD]:=0/;(1+Plus@@(Grade[#,Wedge]&/@{expr})>(Plus@@(DimOfManifold/@DependenciesOf[expr])));
HoldPattern@Diff[expr_,covd_]:=0/;(1+Plus@@(Grade[#,Wedge]&/@{expr})>(Plus@@(DimOfManifold/@DependenciesOf[expr])));]


UseDimensionStop[]:=Module[{},If[!$UseDimensionsQ,Return[]];
$UseDimensionsQ=False;
UnsetZeroForm/@Union@$DimensionsZeroForms;
HoldPattern@Wedge[expr__]=.;
HoldPattern@Diff[expr_,PD]=.;
HoldPattern@Diff[expr_,covd_]=.;]

(* xTensions *)

xTension["xTerior`",DefTensor,"End"]:=DefTensorUseDimensions;
DefTensorUseDimensions[tensor_[inds___],__]:=If[$UseDimensionsQ,SetZeroForm[tensor]];

xTension["xTerior`",UndefTensor,"Beginning"]:=UndefTensorUseDimensions;
UndefTensorUseDimensions[tensor_]:=If[$UseDimensionsQ,UnsetZeroForm[tensor]];



(* ::Subsubsection::Closed:: *)
(*2.2 Integration of CTensor in Wedge*)


(* ::Text:: *)
(*In this section we implement the Wedge product of CTensor objects. This code has been supplied by Jos\[EAcute] Mart\[IAcute]n-Garc\[IAcute]a.*)


(* ::Input::Initialization:: *)
(* Contracted wedge product of CTensor objects *)
Wedge[ctensor1_CTensor[left1___,a_,right1___],ctensor2_CTensor[left2___,-a_,right2___]]:=Module[{n1=Length[{left1,a}],n2=Length[{left2,-a}],res},res=xAct`xCoba`Private`CTensorContract[ctensor1,ctensor2,{n1,n2},Wedge];
res[left1,right1,left2,right2]/;FreeQ[res,$Failed]];

Wedge[ctensor1_CTensor[left1___,-a_,right1___],ctensor2_CTensor[left2___,a_,right2___]]:=Module[{n1=Length[{left1,a}],n2=Length[{left2,-a}],res},res=xAct`xCoba`Private`CTensorContract[ctensor1,ctensor2,{n1,n2},Wedge];
res[left1,right1,left2,right2]/;FreeQ[res,$Failed]];


(* ::Input:: *)
(*(* Wedge product of Frame or Coframe  *)*)


(* ::Input::Initialization:: *)
signatureOrZero[indices_]:=If[DuplicateFreeQ[indices],Signature[Ordering[indices]],0];

simplifyBasisWedge[expr_]:=expr/.wed_Wedge:>simplifyBasisWedge1[wed];
simplifyBasisWedge1[HoldPattern[Wedge[factors:((head:((xAct`xTerior`Coframe|xAct`xTerior`dx)[_]))[_]..)]]]:=With[{indices=First/@{factors}},signatureOrZero[indices] Wedge@@(head/@Sort[indices])]

(* Wedge product of general CTensor objects *)

CTensorWedge[]:=1;
CTensorWedge[ctensors__CTensor]:=CTensor[simplifyBasisWedge[xAct`xCoba`Private`tensorproduct[Wedge]@@#1],Join@@#2,Plus@@#3]&@@Transpose[List@@@{ctensors}];
CTensorWedge[___,Zero,___]:=Zero;

Wedge[ctensor1_CTensor[inds1___],ctensor2_CTensor[inds2___]]:=CTensorWedge[ctensor1,ctensor2][inds1,inds2]/;xAct`xTensor`Private`TakePairs[{inds1,inds2}]==={}


(* ::Text:: *)
(*Wedge product of frame and co-frame with CTensor objects. We first have a definition for Coframe with c - indices, avoiding the use of ToCTensor :*)


(* ::Input::Initialization:: *)
Wedge[basis:(Coframe|dx)[_][_?CIndexQ],CTensor[array_,bases_List,addweight_][b__]]:=CTensor[Wedge[basis,array],bases,addweight][b]

Wedge[CTensor[array_,bases_List,addweight_][b__],basis:(Coframe|dx)[_][_?CIndexQ]]:=CTensor[Wedge[array,basis],bases,addweight][b]


(* ::Text:: *)
(*Then we have another definition for the general case of Wedge, in which the Coframes inside the CTensor uniquely identify the frame to use in ToCTensor :*)


(* ::Input::Initialization:: *)
FormBases[CTensor[array_,__]]:=DeleteDuplicates[xAct`xPerm`Private`nosign/@Cases[array,(Coframe|dx)[_][{_,frame_}]:>frame,{0,Infinity}]]

Wedge[(basis:(Coframe|dx)[_])[ind_],ctensor_CTensor[inds___]]:=With[{frames=FormBases[ctensor]},Wedge[ToCTensor[basis,frames][ind],ctensor[inds]]/;Length[frames]===1]

Wedge[ctensor_CTensor[inds___],(basis:(Coframe|dx)[_])[ind_]]:=With[{frames=FormBases[ctensor]},Wedge[ctensor[inds],ToCTensor[basis,frames][ind]]/;Length[frames]===1]


(* ::Text:: *)
(*Finally we need another definition for the case in which the CTensor is a 0 - form :*)


(* ::Input::Initialization:: *)
CTensor/:(basis:(Coframe|dx)[_])[a_] (ctensor:CTensor[_,bases_List,_][l___,-a_,___]):=ToCTensor[basis,{-bases[[Length[{l,-a}]]]}][a] ctensor


(* ::Input::Initialization:: *)
CTensor/:HoldPattern[Wedge[lw___,(basis:(Coframe|dx)[_])[a_] ,rw___] (ctensor:CTensor[_,bases_List,_][l___,-a_,___])]:=Wedge[lw,ToCTensor[basis,{-bases[[Length[{l,-a}]]]}][a],rw] ctensor


(* ::Subsubsection::Closed:: *)
(*2.3 Definition of the CircleTimes product*)


(* ::Text:: *)
(*By default we define the CircleTimes "\[CircleTimes]" product.*)


(* ::Input::Initialization:: *)
$DefInfoQ=False;


(* ::Input::Initialization:: *)
DefProduct[CircleTimes,
AssociativeProductQ->True,
IdentityElementOfProduct->1,
GradedProductQ->True,
ScalarsOfProduct->(SameQ[Grade[#,CircleTimes],0]&),
PrintAs->"\[CircleTimes]"
]


(* ::Input::Initialization:: *)
$DefInfoQ=True;


(* ::Text:: *)
(*Grade of CircleTimes with respect to Times*)


(* ::Input::Initialization:: *)
CircleTimes/:GradeOfProduct[Times,CircleTimes]=0;


(* ::Text:: *)
(*Exterior algebra grade and tensor grade should coincide on elementary objects:*)


(* ::Input::Initialization:: *)
CircleTimes/:GradeOfTensor[head_,CircleTimes]:=GradeOfTensor[head,Wedge];


(* ::Text:: *)
(*We also need to specify the Grade of the inert - head expressions :*)


(* ::Input::Initialization:: *)
CircleTimes/:Grade[Diff[expr_,_],CircleTimes]:=Grade[expr,CircleTimes]+1;


(* ::Input::Initialization:: *)
CircleTimes/:Grade[Hodge[metricg_][expr_],CircleTimes]:=DimOfVBundle[VBundleOfMetric[metricg]]-Grade[expr,CircleTimes];


(* ::Text:: *)
(*Behavior with respect to Dagger*)


(* ::Input::Initialization:: *)
Unprotect@Dagger;
Dagger@expr_CircleTimes:=Dagger/@expr;
Protect@Dagger;


(* ::Text:: *)
(*The CircleTimes - grade of a form coincides with the Wedge - grade of that form. However, the Wedge - grade is not well defined for generic expressions having positive CircleTimes - grade unless they are forms.That is why we have given CircleTimes - grade in terms of Wedge - grade and not viceversa.There is no general way in which we can know the relations between the grades of a given expression in several products.The user must define carefully the relations. Usually it is safer to declare independently the grades in each product. Recall that objects for which a grade has not been given are taken to have degree 0.*)


(* ::Subsubsection::Closed:: *)
(*2.4 Definition and undefinition of differential forms*)


(* ::Text:: *)
(*Definition and undefinition of differential forms. This is simply DefTensor with the appropriate options*)


(* ::Input:: *)
(*?DefDiffForm*)


(* ::Input::Initialization:: *)
DefDiffForm[form_,mani_,deg_,options___?OptionQ]:=
(DefTensor[form,mani,GradeOfTensor->{Wedge->deg},options];
)


(* ::Input::Initialization:: *)
DefDiffForm[form_,mani_,deg_,sym_,options___?OptionQ]:=
(DefTensor[form,mani,sym,GradeOfTensor->{Wedge->deg},options];
)


(* ::Input::Initialization:: *)
Options@DefDiffForm:=Options@DefTensor;


(* ::Input::Initialization:: *)
UndefDiffForm:=UndefTensor;


(* ::Input::Initialization:: *)
Protect[DefDiffForm,UndefDiffForm];


(* ::Subsubsection::Closed:: *)
(*2.5 Graded derivations*)


(* ::Input:: *)
(*Options@DefInertHead*)


(* ::Text:: *)
(*This function will be used to declare the three derivations we need, namely diff, Int[v] and lie[v]. *)


(* ::Input::Initialization:: *)
Options[DefGradedDerivation]={
PrintAs->Identity
};


(* ::Input::Initialization:: *)
GradeOfDerivation[head_[v_,rest___],prod_]:=GradeOfDerivation[head,prod]+Grade[v,prod];


(* ::Input::Initialization:: *)
DefGradedDerivation[der_,prod_?ProductQ,dergrade_:0,options:OptionsPattern[]]:=With[{head=SubHead[der]},
Module[{pa},

{pa}=OptionValue[{PrintAs}];

(* DefInertHead will take care of scalar-homogeneity and linearity *)
DefInertHead[der,
LinearQ->True,
ContractThrough->{delta},
PrintAs->pa,DefInfo->Null];

(* Other properties of a derivation *)
MakeDerivation[head,der,NoPattern[der],prod,dergrade];

(* Nonatomic derivation *)
If[der=!=head,
(* additivity in the vector slot (but not homogeneity!) *)
head[0][__]:=0;
head[v_Plus][args__]:=head[#][args]&/@v;

(* Subscript vector argument for formatting *)
If[pa===Identity,pa=PrintAs[head]];
head/:MakeBoxes[head[v_][form_],StandardForm]:=xAct`xTensor`Private`interpretbox[head[v][form],RowBox[{SubscriptBox[pa,MakeBoxes[Short@v,StandardForm]],"[",MakeBoxes[form,StandardForm],"]"}]];
]
]
];


(* ::Text:: *)
(*This part is separated in order to avoid renaming confusion between derL and derR:*)


(* ::Input::Initialization:: *)
MakeDerivation[head_,derL_,derR_,prod_,dergrade_]:=With[{grade=GradeOfDerivation[derR,prod]},
(* Addition of grades in algebra *)
head/:GradeOfDerivation[head,prod]:=dergrade;
head/:Grade[derL[expr_,___],prod]:=Grade[expr,prod]+grade;
(* The (graded) Leibniz rule *)
derL[expr_prod,rest___]:=With[{sumgrades=FoldList[Plus,0,Grade[#,Wedge]&/@List@@expr]},
Sum[
(-1)^(grade * sumgrades[[i]] )
MapAt[derR[#,rest]&,expr,i],
{i,1,Length[expr]}
]
];
(* QUESTION: Agreement with a regular derivative when acting on scalar functions?? *)
derL[func_?ScalarFunctionQ[args__],rest___]:=xAct`xTensor`Private`multiD[derR[#,rest]&,func[args]];
(* Dependencies *)
If[!AtomQ[derR],
head/:DependenciesOfInertHead[derL]:=DependenciesOf[First[derR]]
]
];


(* ::Subsubsection::Closed:: *)
(*2.6 Exterior differentiation*)


(* ::Text:: *)
(*The second key ingredient for exterior algebra is the differential operator. This a concept defined per manifold, or equivalently per tangent-bundle, though in this notebook we create only one differential operator.*)


(* ::Input:: *)
(*?Diff*)


(* ::Input::Initialization:: *)
DefGradedDerivation[Diff,Wedge,+1,PrintAs->"d"];


(* ::Text:: *)
(*We always have PD as the covariant derivative.*)


(* ::Input::Initialization:: *)
Diff[expr_]:=Diff[expr,PD]


(* ::Text:: *)
(*Superscript formatting for covariant exterior derivatives*)


(* ::Input::Initialization:: *)
Diff/:MakeBoxes[Diff[form_,PD?CovDQ],StandardForm]:=xAct`xTensor`Private`interpretbox[Diff[form,PD],RowBox[{PrintAs[Diff],"[",MakeBoxes[form,StandardForm],"]"}]];
Diff/:MakeBoxes[Diff[form_,cd_?CovDQ],StandardForm]:=xAct`xTensor`Private`interpretbox[Diff[form,cd],RowBox[{SuperscriptBox[PrintAs[Diff],Last@SymbolOfCovD[cd]],"[",MakeBoxes[form,StandardForm],"]"}]];


(* ::Text:: *)
(*Thread over lists and equal*)


(* ::Input::Initialization:: *)
Diff[expr_?ArrayQ,cd_]:=Diff[#,cd]&/@expr;
Diff[expr_Equal,cd_]:=Diff[#,cd]&/@expr;


(* ::Text:: *)
(*The exterior derivative applied twice is zero:*)


(* ::Input::Initialization:: *)
Diff[expr_Diff,PD]:=0


(* ::Text:: *)
(*Exterior derivative of basis objects is zero. TODO: This is not correct.*)


(* ::Input::Initialization:: *)
Diff[_Basis,PD]:=0;


(* ::Text:: *)
(*We still need definition when acting on Times*)


(* ::Input::Initialization:: *)
(* This produces expanded expressions and is much faster when there are many scalars *)
Diff[expr_Times,cd_]:=Module[{grades=Grade[#,Wedge]&/@List@@expr,pos,scalar,form},
pos=Position[grades,_?Positive,1,Heads->False];
Which[
Length[pos]>1,
	Throw[Message[Diff::error1,"Found Times product of nonscalar forms: ",expr]],
Length[pos]===1,
	pos=pos[[1,1]];
	scalar=Delete[expr,{pos}];
	form=expr[[pos]];
	scalar Diff[form,cd]+diff0[scalar,cd,form],
Length[pos]===0,
	diff0[expr,cd]
]
];
(* Only scalars *)
diff0[scalar_Times,cd_]:=Sum[MapAt[Diff[#,cd]&,scalar,i],{i,1,Length[scalar]}];
diff0[scalar_,cd_]:=Diff[scalar,cd];
(* Scalars and a form *)
diff0[scalar_Times,cd_,form_]:=Sum[MapAt[diff0[#,cd,form]&,scalar,i],{i,1,Length[scalar]}];
diff0[scalar_,cd_,form_]:=Wedge[Diff[scalar,cd],form];


(* ::Input::Initialization:: *)
Diff[x_?ConstantQ,cd_]:=0;


(* ::Text:: *)
(*Behavior with respect to Dagger.*)


(* ::Input::Initialization:: *)
Diff/:HoldPattern[Dagger[Diff[expr_,cd_]]]:=Diff[Dagger[expr],cd];


(* ::Text:: *)
(*Behaviour with respect to CTensor*)


(* ::Input::Initialization:: *)
Diff[CTensor[array_,bases_List,weight_][inds__],cd_]:=CTensor[Diff[array,cd],bases,weight][inds];


(* ::Subsubsection::Closed:: *)
(*2.7 Introduction of co-frame*)


(* ::Text:: *)
(*We create the non-atomic tensor \[Theta][M] representing a co-frame. Note that the formatting does not contain the manifold as this information is already visible in the abstract index. The abstract index may belong to the tangent space of the manifold "M" or to any other vector bundle with base M. In the case of the abstract index belonging to TangentM we can think of \[Theta][M] as the set of "canonical 1-forms". *)


(* ::Input::Initialization:: *)
xTensorQ@Coframe[mani_?ManifoldQ]^=True;
SlotsOfTensor[Coframe[mani_?ManifoldQ]]^:={Tangent@mani};
Coframe/:GradeOfTensor[Coframe[mani_?ManifoldQ],Wedge]=1;
SymmetryGroupOfTensor[Coframe[mani_?ManifoldQ]]^=StrongGenSet[{},GenSet[]];
DefInfo[Coframe[mani_?ManifoldQ]]^={"General co-frame",""};
DependenciesOfTensor[Coframe[mani_?ManifoldQ]]^:={mani};
HostsOf[Coframe[mani_?ManifoldQ]]^={};
TensorID[Coframe[mani_?ManifoldQ]]^={};
PrintAs[Coframe[mani_?ManifoldQ]]^="\[Theta]";


(* ::Input::Initialization:: *)
Unprotect@Dagger;
Dagger[Coframe[mani_?ManifoldQ]]:=Coframe[mani];
Protect@Dagger;


(* ::Text:: *)
(*Holonomic Co-frame*)


(* ::Input::Initialization:: *)
xTensorQ@dx[mani_?ManifoldQ]^=True;
SlotsOfTensor[dx[mani_?ManifoldQ]]^:={Tangent@mani};
dx/:GradeOfTensor[dx[mani_?ManifoldQ],Wedge]=1;
SymmetryGroupOfTensor[dx[mani_?ManifoldQ]]^=StrongGenSet[{},GenSet[]];
DefInfo[dx[mani_?ManifoldQ]]^={"General co-frame",""};
DependenciesOfTensor[dx[mani_?ManifoldQ]]^:={mani};
HostsOf[dx[mani_?ManifoldQ]]^={};
TensorID[dx[mani_?ManifoldQ]]^={};
PrintAs[dx[mani_?ManifoldQ]]^="dx";


(* ::Input::Initialization:: *)
Unprotect@Dagger;
Dagger[dx[mani_?ManifoldQ]]:=dx[mani];
Protect@Dagger;


(* ::Text:: *)
(*Condition of the co-frame being holonomic.*)


(* ::Input::Initialization:: *)
Diff[dx[mani_?ManifoldQ][ind_],PD]:=0;


(* ::Input::Initialization:: *)
(* xTensions *)
xTension["xTerior`",DefChart,"End"]:=setdiffs;
setdiffs[chartname_,__]:=Thread[ComponentValue[dx[ManifoldOfChart@chartname][{#,chartname}]&/@CNumbersOf@chartname,Diff/@ScalarsOfChart@chartname]];


(* ::Subsubsection::Closed:: *)
(*2.8 The Hodge dual*)


(* ::Input:: *)
(*?Hodge*)


(* ::Text:: *)
(*The third basic ingredient of exterior algebra is Hodge duality, which requires the presence of a metric.*)


(* ::Input::Initialization:: *)
DefInertHead[Hodge[metric_],
LinearQ->True,
ContractThrough->{delta},
DefInfo->Null
]


(* ::Input::Initialization:: *)
Hodge/:PrintAs@Hodge[metric_]:=If[Head[metric]===CTensor,"*","\!\(\*SubscriptBox[\(*\), \("<>PrintAs[metric]<>"\)]\)"];


(* ::Text:: *)
(*Thread over lists and equal*)


(* ::Input::Initialization:: *)
Hodge[metric_][expr_List]:=Hodge[metric][#]&/@expr;
Hodge[metric_][expr_Equal]:=Hodge[metric][#]&/@expr;


(* ::Text:: *)
(*Hodge of a CTensor object*)


(* ::Input::Initialization:: *)
Hodge[metric_][CTensor[array_,bases_List,weight_][inds__]]:=CTensor[Hodge[metric][array],bases,weight][inds];


(* ::Text:: *)
(*Hodge of the product of two objects*)


(* ::Input::Initialization:: *)
Hodge[metric_][x_ y_]:=x Hodge[metric][y]/;Grade[x,Wedge]===0


(* ::Text:: *)
(*[Jose: This previous definition overlaps with LinearQ->True, so we might want to rethink that option in relation with the products and ScalarsOfProduct.]*)


(* ::Input::Initialization:: *)
DimOfMetric[metric_]:=DimOfVBundle[VBundleOfMetric[metric]]


(* ::Input::Initialization:: *)
Hodge/:Grade[Hodge[metric_][expr_],Wedge]:=DimOfMetric[metric]-Grade[expr,Wedge]


(* ::Input::Initialization:: *)
Hodge[metric_]@Hodge[metric_][expr_]:=(-1)^(Grade[expr,Wedge](DimOfMetric[metric]-1)+SignatureOfMetric[metric][[2]])expr


(* ::Text:: *)
(*This function converts Hodge duals of product of the coframe basis (either holonomic or non-holonomic):*)


(* ::Input:: *)
(*?ExpandHodgeDual*)


(* ::Input::Initialization:: *)
(* Expand dual of differentials of coordinate elements *)
ExpandHodgeDual[expr_,dx[mani_?ManifoldQ],met_]:=ExpandHodgeDual1[(expr/.Reverse/@Flatten[List@@TensorValues@dx[mani]]),dx[mani],met];
(* Expand of the wedge product of canonical 1-forms *)
ExpandHodgeDual[expr_,(coframe:(Coframe|dx))[mani_?ManifoldQ],met_]:=ExpandHodgeDual1[expr,coframe[mani],met];


(* ::Input::Initialization:: *)
ExpandHodgeDual1[expr_,(coframe:(Coframe|dx))[mani_?ManifoldQ],met_]:=
expr/.{HoldPattern[Hodge[met][form:Wedge[coframe[mani][_]..]]|form:Hodge[met][coframe[mani][_]]]:>With[{dim=DimOfMetric[met],n=Length[form],inds=Sequence@@@List@@form},
With[{dummies=DummyIn/@ConstantArray[VBundleOfMetric[met],dim-n]},
1/(dim-n)!epsilon[met]@@Join[inds,ChangeIndex/@dummies]Wedge@@(coframe[mani]/@dummies)
]
],HoldPattern[Hodge[met][form_]]:>With[{dim=DimOfMetric[met]},
With[{dummies=DummyIn/@ConstantArray[VBundleOfMetric[met],dim]},
form/(dim)!epsilon[met]@@(ChangeIndex/@dummies)Wedge@@(coframe[mani]/@dummies)
]
]/;(Deg[form]===0)};


(* ::Input::Initialization:: *)
ExpandHodgeDual1[expr_,Coframe,met_]:=Fold[ExpandHodgeDual1[#1,Coframe[#2],met]&,expr,$Manifolds];


(* ::Input::Initialization:: *)
ExpandHodgeDual1[expr_,dx,met_]:=Fold[ExpandHodgeDual1[#1,dx[#2],met]&,expr,$Manifolds];


(* ::Subsubsection::Closed:: *)
(*2.9 The co-differential*)


(* ::Text:: *)
(*We introduce the co-differential.*)


(* ::Input::Initialization:: *)
DefInertHead[Codiff[metric_],
LinearQ->True,
ContractThrough->delta,
DefInfo->Null
];


(* ::Input::Initialization:: *)
Codiff/:PrintAs@Codiff[metric_]:=If[Head@metric===CTensor,"\[Delta]","\!\(\*SubscriptBox[\(\[Delta]\), \("<>PrintAs[metric]<>"\)]\)"];


(* ::Input::Initialization:: *)
Codiff/:Grade[Codiff[metric_][expr_,___],Wedge]:=-1+Grade[expr,Wedge]


(* ::Input::Initialization:: *)
Codiff/:MakeBoxes[Codiff[metric_][form_,PD?CovDQ],StandardForm]:=xAct`xTensor`Private`interpretbox[Codiff[metric][form,PD],RowBox[{PrintAs[Codiff[metric]],"[",MakeBoxes[form,StandardForm],"]"}]];
Codiff/:MakeBoxes[Codiff[metric_][form_,cd_?CovDQ],StandardForm]:=xAct`xTensor`Private`interpretbox[Codiff[metric][form,cd],RowBox[{SuperscriptBox[PrintAs[Codiff[metric]],Last@SymbolOfCovD[cd]],"[",MakeBoxes[form,StandardForm],"]"}]];


(* ::Text:: *)
(*We always have PD as the covariant derivative.*)


(* ::Input::Initialization:: *)
HoldPattern[Codiff[met_][expr_]]:=Codiff[met][expr,PD];


(* ::Input::Initialization:: *)
CodiffToDiff[expr_]:=expr//.Codiff[met_][expr1_,covd_?CovDQ]:>(-1)^(DimOfMetric[met]Grade[expr1,Wedge]+DimOfMetric[met]+1+SignatureOfMetric[met][[2]]+1)Hodge[met]@Diff[Hodge[met]@expr1,covd]


(* ::Text:: *)
(*For convenience we program this identity:*)


(* ::Input::Initialization:: *)
Codiff[metric_][Codiff[metric_][expr_,PD]]:=0


(* ::Text:: *)
(*Co-differential of basis objects is zero.*)


(* ::Input::Initialization:: *)
Codiff[_Basis,covd_?CovDQ]:=0;


(* ::Text:: *)
(*Thread over lists and equal*)


(* ::Input::Initialization:: *)
Codiff@expr_List:=Codiff/@expr;
Codiff@expr_Equal:=Codiff/@expr;


(* ::Subsubsection::Closed:: *)
(*2.10 Poincar\[EAcute] lemma*)


(* ::Text:: *)
(*We implement the computation of the potential for an exact form (Poincar\[EAcute] lemma)*)


(* ::Input::Initialization:: *)
FindPotential[expr_Plus,point_List,chart_?ChartQ,options:OptionsPattern[Integrate]]:=FindPotential[#,point,chart,options]&/@expr;
FindPotential[expr_Times,point_List,chart_?ChartQ,options:OptionsPattern[Integrate]]:=FindPotential[Expand@expr,point,chart,options];


(* ::Input::Initialization:: *)
(*Simplest cases for grade 1 forms *)
FindPotential[expr_Diff,point_List,chart_?ChartQ,options:OptionsPattern[Integrate]]:=Part[expr,1];

FindPotential[factor_ expr_Diff,point_List,chart_?ChartQ,options:OptionsPattern[Integrate]]:=Integrate1[(factor/.Thread[Rule[ScalarsOfChart@chart,Times[#,t]&/@(ScalarsOfChart@chart-point)+point]]) (Part[expr,1]-Part[point,First@Flatten@Position[ScalarsOfChart@chart,Part[expr,1]]]),{t,0,1},options];
(* Do the actual integration *)
Integrate1/:HoldPattern@Plus[var__Integrate1]:=Integrate[Plus@@First/@{var},{t,0,1}];



(* ::Input::Initialization:: *)
(* Poincare Lemma for higher degree forms *)
FindPotential[factor_. expr_Wedge,point_List,chart_?ChartQ,options:OptionsPattern[Integrate]]:=Integrate[(factor/.Thread[Rule[ScalarsOfChart@chart,Times[#,t]&/@(ScalarsOfChart@chart-point)+point]]) Sum[(-1)^(i-1)t^(Deg@expr-1) (Part[expr,i,1]-Part[point,First@Flatten@Position[ScalarsOfChart@chart,Part[expr,i,1]]])Delete[expr,{i}],{i,1,Length[expr]}],{t,0,1},options];


(* ::Subsubsection::Closed:: *)
(*2.11. Integration of differential forms*)


(* ::Text:: *)
(*Formatting of integration of differential forms:*)


(* ::Input::Initialization:: *)
FormIntegrate::dim="Degree of form `1` is incompatible with dimension of manifold `2`.";


(* ::Input::Initialization:: *)
InertHeadQ[FormIntegrate]^:=True;
LinearQ[FormIntegrate]^:=True;
FormIntegrate[form_,EmptyManifold]:=0;
FormIntegrate[c_?ConstantQ,man_?ManifoldQ]:=c/;DimOfManifold[man]==0;
FormIntegrate[form_,man_?ManifoldQ]:=Throw[Message[FormIntegrate::dim,form,man];$Failed]/;Deg[form]=!=DimOfManifold[man];
ToCanonical[FormIntegrate[form_,man_],opts___]^:=FormIntegrate[ToCanonical[form,opts],man];
FormIntegrate/:Grade[FormIntegrate[form_,man_],Wedge]:=0/;Deg[form]===DimOfManifold[man];


(* ::Input::Initialization:: *)
(* Formatting. Do not remove the ugly ?InertHeadQ check here. It would break typesetting *)
MakeBoxes[FormIntegrate?InertHeadQ[form_,man_],StandardForm]:=RowBox[{SubscriptBox["\[Integral]",MakeBoxes[man,StandardForm]],MakeBoxes[form,StandardForm]}];


(* ::Text:: *)
(*Use the Stokes theorem. By default it converts n-dimensional integration into (n-1)-dimensional integration, but using the two-argument form, UseStokes can work in both directions:*)


(* ::Input::Initialization:: *)
UseStokes[expr_]:=expr/.HoldPattern[FormIntegrate[Diff[form_,PD],man_]]:>FormIntegrate[form,ManifoldBoundary[man]];
UseStokes[expr_,man_?ManifoldQ]:=expr/.HoldPattern[FormIntegrate[Diff[form_,PD],man]]:>FormIntegrate[form,ManifoldBoundary[man]];
UseStokes[expr_,form_]:=expr/.HoldPattern[FormIntegrate[form,ManifoldBoundary[man_]]]:>FormIntegrate[Diff[form],man];


(* ::Input:: *)
(*Options[DefInertHead]*)


(* ::Subsection::RGBColor[0, 0, 1]:: *)
(*3. Graded derivations*)


(* ::Subsubsection::Closed:: *)
(*3.1 Connection forms *)


(* ::Text:: *)
(*There are two objects we need for covariant exterior derivatives. First, 1-forms taking values in VB\[CircleTimes]-VB which represent the tensorial difference between two connections. Second, 2-forms taking values in VB\[CircleTimes]-VB which represent the curvature of an individual connection. We'll use nonatomic heads for both of these. The notation will be*)
(*  ConnectionForm[CD1,CD2,VB][A,-B]*)
(*  CurvatureForm[CD,VB][A,-B]*)


(* ::Text:: *)
(*From a mathematical point of view the connection form should not be regarded as the tensorial difference between two connections. The reason for this is that the connection form is defined as a 1-form in the frame bundle regarded as a differentiable manifold and in this sense it is truly tensorial. One loses the tensorial character when one does a splitting of the frame bundle into the base manifold and the fibres. For this reason we use the following notation for the connection form:*)
(**)
(*ConnectionForm[CD,VB][A,-B]*)
(**)
(*This notation has been implemented in this notebook.*)


(* ::Text:: *)
(*First, making these nonatomic-head tensors. We start by the general connection form.  What happens with the MastersOf a non-atomic symbol ? Given that a non-atomic tensor cannot be undefined I guess that it makes no sense to ask about its Masters,  right ?  Also I guess that it cannot be Servant of anything either.*)


(* ::Input::Initialization:: *)
xTensorQ[ConnectionForm[cd_?CovDQ,_]]^=True;
SlotsOfTensor[ConnectionForm[_,vb_?VBundleQ]]^:={vb,-vb};
ConnectionForm/:GradeOfTensor[ConnectionForm[_,_],Wedge]=1;
SymmetryGroupOfTensor[ConnectionForm[_,_]]^=StrongGenSet[{},GenSet[]];

Dagger[ConnectionForm[cd1_,vb_]]^:=ConnectionForm[cd1,Dagger@vb];
DefInfo[ConnectionForm[_,_]]^={"nonsymmetric Connection 1-form",""};
DependenciesOfTensor[ConnectionForm[cd1_,_]]^:=Union@@DependenciesOfCovD/@{cd1};
HostsOf[ConnectionForm[cd1_,vb_]]^:=Join[{cd1},Union@@HostsOf/@{cd1,vb}];(* Should we put Union@@HostsOf/@{cd1,vb} here? Yes but we need to add cd1 itself *)
TensorID[ConnectionForm[_,_]]^={};

PrintAs[ConnectionForm]^="A";
PrintAs[ConnectionForm[cd1_,_]]^:=PrintAs[ConnectionForm]<>"["<>Last@SymbolOfCovD[cd1]<>"]";
PrintAs[ConnectionForm[PD,_]]^:=PrintAs[ConnectionForm];


(* ::Text:: *)
(*We introduce now the ChristoffelForm (connection form for a connection in the frame bundle). *)


(* ::Input::Initialization:: *)
xTensorQ[ChristoffelForm[cd1_?CovDQ]]^=True;
SlotsOfTensor[ChristoffelForm[cd1_?CovDQ]]^:={Tangent@ManifoldOfCovD@cd1,-Tangent@ManifoldOfCovD@cd1};
ChristoffelForm/:GradeOfTensor[ChristoffelForm[_],Wedge]=1;
SymmetryGroupOfTensor[ChristoffelForm[_]]^=StrongGenSet[{},GenSet[]];

Dagger[ChristoffelForm[cd1_]]^:=ChristoffelForm[cd1];
DefInfo[ChristoffelForm[_]]^={"nonsymmetric frame bundle Connection 1-form",""};
DependenciesOfTensor[ChristoffelForm[cd1_]]^:=Union@@DependenciesOfCovD/@{cd1};
HostsOf[ChristoffelForm[cd1_]]^:=Join[{cd1},Union@@HostsOf/@{cd1}];(* Should we put Union@@HostsOf/@{cd1,cd2,vb} here? Yes, but addint also cd1 *)
TensorID[ChristoffelForm[_]]^={};

PrintAs[ChristoffelForm]^="\[CapitalGamma]";
(PrintAs[ChristoffelForm[cd1_]]/;Head@cd1=!=CCovD)^:=PrintAs[ChristoffelForm]<>"["<>Last@SymbolOfCovD[cd1]<>"]";
PrintAs[ChristoffelForm[PD]]^:=PrintAs[ChristoffelForm];


(* ::Text:: *)
(*Christoffel form when the metric is given as a CTensor*)


(* ::Input::Initialization:: *)
ChristoffelForm[exr_CCovD]:=Head@Module[{ind=DummyIn@VBundleOfBasis[-Part[exr,2,2,2]],a1,a2},{a1,a2}=GetIndicesOfVBundle[VBundleOfBasis[Part[exr,2,2,1]],2];
Part[exr,2][a1,-ind,-a2] Coframe[BaseOfVBundle@VBundleOfBasis[-Part[exr,2,2,2]]][ind]];


(* ::Text:: *)
(*Connection form for a non-metric CCovD. In this case the last argument of the CCovD is Null. *)


(* ::Input::Initialization:: *)
ConnectionForm[exr_CCovD,vb_]:=Head@Module[{ind=DummyIn@VBundleOfBasis[-Part[exr,2,2,2]],a1,a2},{a1,a2}=GetIndicesOfVBundle[VBundleOfBasis[Part[exr,2,2,1]],2];
Part[exr,2][a1,-ind,-a2] Coframe[BaseOfVBundle@VBundleOfBasis[-Part[exr,2,2,2]]][ind]];


(* ::Text:: *)
(*Automatic replacement of the connection form by the Christoffel form when the connection corresponds to a connection in a frame bundle.*)


(* ::Input::Initialization:: *)
ConnectionForm[cd1_,vb_]:=ChristoffelForm[cd1]/;(Tangent@ManifoldOfCovD@cd1===vb);
ChristoffelForm[cd_,tangentbundle_]:=ChristoffelForm[cd];


(* ::Text:: *)
(*PD is regarded as a trivial connection in a principal bundle. Hence:*)


(* ::Input::Initialization:: *)
ConnectionForm[PD,vb_]:=Zero;
ChristoffelForm[PD]:=Zero;


(* ::Text:: *)
(*Transformation of the connection form into the connection tensor plus co-frame.*)


(* ::Input::Initialization:: *)
ConnectionFormToTensor[expr_,covd_,frame:(Coframe|dx)]:=expr/.{ChristoffelForm[cd1_][ind1_,ind2_]:>Module[{a=DummyIn@First@VBundlesOfCovD@covd},
If[xTensorQ@GiveSymbol[Christoffel,cd1,covd]===False,DefTensor[GiveSymbol[Christoffel,cd1,covd][ind1,-a,ind2],ManifoldOfCovD@covd]];
GiveSymbol[Christoffel,cd1,covd][ind1,-a,ind2]frame[ManifoldOfCovD@covd][a]]/;covd=!=PD,ConnectionForm[cd1_,vbundle_][ind1_,ind2_]:>Module[{a=DummyIn@Tangent@BaseOfVBundle@vbundle},If[xTensorQ@GiveSymbol[AChristoffel,covd,cd1]===False,DefTensor[GiveSymbol[AChristoffel,covd,cd1][ind1,-a,ind2],BaseOfVBundle@vbundle]];
GiveSymbol[AChristoffel,covd,cd1][ind1,-a,ind2]frame[BaseOfVBundle@vbundle][a]]/;covd=!=PD};


(* ::Text:: *)
(*If the covariant derivative is PD then the code takes the following simpler form:*)


(* ::Input::Initialization:: *)
ConnectionFormToTensor[expr_,PD,frame:(Coframe|dx)]:=expr/.{ChristoffelForm[cd1_][ind1_,ind2_]:>Module[{a=DummyIn@First@VBundlesOfCovD@cd1},
GiveSymbol[Christoffel,cd1][ind1,-a,ind2]frame[ManifoldOfCovD@cd1][a]],ConnectionForm[cd1_,_][ind1_,ind2_]:>Module[{a=DummyIn@First@VBundlesOfCovD@cd1},
GiveSymbol[AChristoffel,cd1][ind1,-a,ind2]frame[ManifoldOfCovD@cd1][a]]}


(* ::Subsubsection::Closed:: *)
(*3.2 Curvature forms *)


(* ::Text:: *)
(*Now for the curvature form:*)


(* ::Input::Initialization:: *)
xTensorQ[CurvatureForm[_,_]]^=True;
SlotsOfTensor[CurvatureForm[_,vb_?VBundleQ]]^:={vb,-vb};
CurvatureForm/:GradeOfTensor[CurvatureForm[_,_],Wedge]=2;
SymmetryGroupOfTensor[CurvatureForm[_,_]]^=StrongGenSet[{},GenSet[]];

Dagger[CurvatureForm[cd_,vb_]]^:=CurvatureForm[cd,Dagger@vb];
DefInfo[CurvatureForm[_,_]]^={"Curvature 2-form",""};
DependenciesOfTensor[CurvatureForm[cd_,_]]^:=DependenciesOfCovD[cd];
HostsOf[CurvatureForm[cd_,vb_]]^:=Join[{cd},Union@@HostsOf/@{cd,vb}];(* Should we put Union@@HostsOf/@{cd,vb} here? Yes but we need to add cd itself *)
TensorID[CurvatureForm[_,_]]^={};

PrintAs[CurvatureForm]^="F";
PrintAs[CurvatureForm[cd_,_]]^:=PrintAs[CurvatureForm]<>"["<>Last@SymbolOfCovD[cd]<>"]";


(* ::Text:: *)
(*Case of a connection in the frame bundle (RiemannForm)*)


(* ::Input::Initialization:: *)
xTensorQ[RiemannForm[_]]^=True;
SlotsOfTensor[RiemannForm[cd_?CovDQ]]^:={Tangent@ManifoldOfCovD@cd,-Tangent@ManifoldOfCovD@cd};
RiemannForm/:GradeOfTensor[RiemannForm[_],Wedge]=2;
SymmetryGroupOfTensor[RiemannForm[cd_?CovDQ]]^:=If[MetricOfCovD@cd=!=Null,
Antisymmetric[{1,2},Cycles],
StrongGenSet[{},GenSet[]]];

Dagger[RiemannForm[cd_]]^:=RiemannForm[cd];
DefInfo[RiemannForm[_]]^={"Curvature 2-form in the frame bundle",""};
DependenciesOfTensor[RiemannForm[cd_]]^:=DependenciesOfCovD[cd];
HostsOf[RiemannForm[cd_]]^:=Join[{cd},Union@@HostsOf/@{cd}];(* Should we put Union@@HostsOf/@{cd,vb} here? Yes but we need to add cd itself *)
TensorID[RiemannForm[_]]^={};

PrintAs[RiemannForm]^="R";
(PrintAs[RiemannForm[cd_]]/;Head@cd=!=CCovD)^:=PrintAs[RiemannForm]<>"["<>Last@SymbolOfCovD[cd]<>"]";


(* ::Text:: *)
(*Riemann form of a CTensor expression:*)


(* ::Input::Initialization:: *)
RiemannForm[exr_CCovD]:=If[Riemann[exr]=!=Zero,Head@Module[{tbundle,ind1,ind2,a1,a2},
tbundle=VBundleOfBasis[-Part[exr,2,2,2]];
ind1=DummyIn@tbundle;
ind2=DummyIn@tbundle;
{a1,a2}=GetIndicesOfVBundle[VBundleOfBasis[Part[exr,2,2,1]],2];
Riemann[exr][-ind1,-ind2,-a1,a2]  Wedge[Coframe[BaseOfVBundle@tbundle][ind1],Coframe[BaseOfVBundle@tbundle][ind2]]
],
Zero
];


(* ::Text:: *)
(*Curvature form of a CTensor expression. TODO: FRiemann doesn't work with CCovD connections.*)


(* ::Input::Initialization:: *)
CurvatureForm[exr_CCovD,vbundle_]:=If[FRiemann[exr]=!=Zero,Head@Module[{tbundle,ind1,ind2,a1,a2},
tbundle=VBundleOfBasis[-Part[exr,2,2,2]];
ind1=DummyIn@tbundle;
ind2=DummyIn@tbundle;
{a1,a2}=GetIndicesOfVBundle[vbundle,2];
FRiemann[exr][-ind1,-ind2,-a1,a2]  Wedge[Coframe[BaseOfVBundle@tbundle][ind1],Coframe[BaseOfVBundle@tbundle][ind2]]
],Zero
];


(* ::Text:: *)
(*Automatic replacement of the curvature form if the covariant derivative corresponds to a covariant derivative defined in the tangent bundle.*)


(* ::Input::Initialization:: *)
CurvatureForm[cd_?CovDQ,vbundle_]:=RiemannForm[cd]/;vbundle===Tangent@ManifoldOfCovD@cd;
RiemannForm[cd_,vbundle_]:=RiemannForm[cd];


(* ::Text:: *)
(*Transformation of the Curvature form into the curvature tensor plus co-frame.*)


(* ::Input::Initialization:: *)
CurvatureFormToTensor[expr_,frame:(Coframe|dx)]:=expr/.{HoldPattern@CurvatureForm[cd1_,vbundle1_?VBundleQ][inds__]:>Module[{a=DummyIn@First@VBundlesOfCovD@cd1,b=DummyIn@First@VBundlesOfCovD@cd1},
1/2GiveSymbol[FRiemann,cd1][-a,-b,Sequence@@Reverse@List@inds]Wedge[frame[ManifoldOfCovD@cd1][a],frame[ManifoldOfCovD@cd1][b]]],RiemannForm[cd1_][inds__]:>Module[{a=DummyIn@First@VBundlesOfCovD@cd1,b=DummyIn@First@VBundlesOfCovD@cd1},
-$RiemannSign 1/2GiveSymbol[Riemann,cd1][-a,-b,Sequence@@Reverse@List@inds]Wedge[frame[ManifoldOfCovD@cd1][a],frame[ManifoldOfCovD@cd1][b]]]}


(* ::Subsubsection::Closed:: *)
(*3.3 The torsion 2-form*)


(* ::Text:: *)
(*The torsion 2-form (only for covariant derivatives on the tangent bundle)*)


(* ::Input::Initialization:: *)
xTensorQ[TorsionForm[_]]^=True;
SlotsOfTensor[TorsionForm[cd_]]^:={Tangent@ManifoldOfCovD@cd};
TorsionForm/:GradeOfTensor[TorsionForm[_],Wedge]=2;
SymmetryGroupOfTensor[TorsionForm[_]]^=StrongGenSet[{},GenSet[]];

Dagger[TorsionForm[cd_]]^:=TorsionForm[cd]
DefInfo[TorsionForm[_]]^={"Torsion 2-form",""};
DependenciesOfTensor[TorsionForm[cd_]]^:=DependenciesOfCovD[cd];
HostsOf[TorsionForm[cd_]]^:=HostsOf@cd;(* Should we put HostsOf@cd here? OK*)
TensorID[TorsionForm[_]]^={};


(* ::Input::Initialization:: *)
PrintAs[TorsionForm]^="\[GothicCapitalT]";
(PrintAs[TorsionForm[cd_]]/;Head@cd=!=CCovD)^:=PrintAs[TorsionForm]<>"["<>Last@SymbolOfCovD[cd]<>"]";


(* ::Text:: *)
(*Torsion form of a covariant derivative of a metric given as a CTensor*)


(* ::Input::Initialization:: *)
TorsionForm[exr_CCovD]:=Head@Module[{ind1=DummyIn@VBundleOfBasis[-First@Part[Last@exr,2]],ind2=DummyIn@VBundleOfBasis[-First@Part[Last@exr,2]],a1},
{a1}=GetIndicesOfVBundle[VBundleOfBasis[-First@Part[Last@exr,2]],1];
Torsion[exr][a1,-ind1,-ind2] ToCTensor[Coframe[BaseOfVBundle@VBundleOfBasis[-First@Part[Part[exr,3],2]]],{-First@Part[Part[exr,3],2]}][ind1]\[Wedge]ToCTensor[Coframe[BaseOfVBundle@VBundleOfBasis[-First@Part[Part[exr,3],2]]],{-First@Part[Part[exr,3],2]}][ind2]
];


(* ::Subsubsection::Closed:: *)
(*3.4 Change of exterior covariant derivative*)


(* ::Text:: *)
(*We will use a convention that there should be a correspondence *)
(*  AChr1[CD1,CD2,VB][A,-B] -> AChristoffel[CD1,CD2][A,-\[Mu],-B] \[Theta][\[Mu]]*)
(*  FRiem2[CD,VB][A,-B] -> 1/2 FRiemann[CD][-\[Mu],-\[Nu],-B,A] \[Theta][\[Mu]]\[Wedge]\[Theta][\[Nu]]          (notice different ordering of A,B on two sides)*)
(*  Torsion2[CD][\[Alpha]] -> 1/2 Torsion[CD][\[Alpha],-\[Beta],-\[Gamma]] \[Theta][\[Beta]]\[Wedge]\[Theta][\[Gamma]]*)
(*We'll want to be able to*)
(*  1) Change from diff[form,CD1] to diff[form,CD2], introducing AChr1[CD1,CD2,...] as needed*)
(*  2) Compute diff[diff[form,CD],CD], introducing FRiem2[CD,...] as needed*)
(*  3) Change from FRiem2[CD1,VB] to FRiem2[CD2,VB], introducing diff[AChr1[CD...]] and Wedge[AChr1,AChr1]*)


(* ::Text:: *)
(*1. Change from diff[form,CD1] to diff[form,CD2]. The formula is:*)
(*  d^CD1 v^A-d^CD2 v^A  = \!\( *)
(*\*SubsuperscriptBox[\(A[CD1, CD2, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)]\[Wedge]*)
(*\*SuperscriptBox[\(v\), \(B\)]\)     (where VB is the VBundle of A; plus sign for +VB, minus sign for -VB)*)
(*TODO: What about densities? Alfonso: I'm not sure whether the distinction "true tensor" / "tensor density" holds in this context.*)


(* ::Input:: *)
(*?ChangeExtD*)


(* ::Text:: *)
(*ConnectionForm with two covariant derivatives as arguments represents the difference between two connection forms which carry only a covariant derivative in the argument.*)


(* ::Input::Initialization:: *)
ConnectionForm[cd1_,cd2_,vbundle_][inds__]:=ConnectionForm[cd1,vbundle][inds]-ConnectionForm[cd2,vbundle][inds];


(* ::Input::Initialization:: *)
ChangeExtD[expr_,cd_?CovDQ,cd_]:=expr;
ChangeExtD[expr_,cd1_?CovDQ,cd2_:PD]:=expr/.HoldPattern[Diff[expr1_,cd1]]:>
makeChangeExtD[ChangeExtD[expr1,cd1,cd2],cd1,cd2];

ChangeExtD[expr_,list_List,covd2_:PD]:=Fold[ChangeExtD[#1,#2,covd2]&,expr,list];
ChangeExtD[expr_,x_,_:PD]:=Throw@Message[ChangeExtD::unknown,"covariant derivative",x];
ChangeExtD[expr_]:=ChangeExtD[expr,$CovDs];


(* ::Input::Initialization:: *)
makeChangeExtD[expr_,cd1_,cd2_]:=With[{vbs=Apply[Union,VBundlesOfCovD/@DeleteCases[{cd1,cd2},PD]]},
Diff[expr,cd2]+Plus@@Map[addAChr1[expr,cd1,cd2],xAct`xTensor`Private`selecton[Select[FindFreeIndices@expr,GIndexQ],vbs]]//ReduceAChr1
];


(* ::Input::Initialization:: *)
addAChr1[expr_,cd1_,cd2_][{oldind_?xAct`xTensor`Private`upQ,dummy_}]:=Wedge[ConnectionForm[cd1,cd2,VBundleOfIndex@oldind][oldind,-dummy],ReplaceIndex[expr,oldind->dummy]]
addAChr1[expr_,cd1_,cd2_][{oldind_?xAct`xTensor`Private`downQ,dummy_}]:=-Wedge[ConnectionForm[cd1,cd2,VBundleOfIndex@oldind][dummy,oldind],ReplaceIndex[expr,oldind->-dummy]]


(* ::Text:: *)
(*Note that*)
(*  d^CD1 v^A-d^CD2 v^A  = d^CD1 v^A-d v^A+d v^A- d^CD2 v^A=\!\(TraditionalForm\`*)
(*\*SubsuperscriptBox[\(A[CD1, PD, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)]\[Wedge]*)
(*\*SuperscriptBox[\(v\), \(B\)]\)+\!\(TraditionalForm\`*)
(*\*SubsuperscriptBox[\(A[PD, CD2, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)]\[Wedge]*)
(*\*SuperscriptBox[\(v\), \(B\)]\)*)
(*and so*)
(*  \!\( *)
(*\*SubsuperscriptBox[\(A[CD1, CD2, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)] = \( *)
(*\*SubsuperscriptBox[\(A[CD1, PD, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)] + *)
(*\*SubsuperscriptBox[\(A[PD, CD2, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)]\)\).*)
(*Now \!\(\*SubsuperscriptBox[\(A[CD, PD, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)]\)=0  iff FreeQ[VBundlesOfCovD[CD],VB]. This allows the simplification of A[CD1,CD2,VB] when only one of {CD1,CD2} has VB in VBundlesOfCovD.*)


(* ::Input::Initialization:: *)
ReduceAChr1[expr_]:=expr//.{ConnectionForm[cd1_,cd2_,vb_][a_,b_]:>ConnectionForm[cd1,PD,vb][a,b]/;(cd2=!=PD&&FreeQ[VBundlesOfCovD@cd2,vb]),
ConnectionForm[cd1_,cd2_,vb_][a_,b_]:>ConnectionForm[PD,cd2,vb][a,b]/;(cd1=!=PD&&FreeQ[VBundlesOfCovD@cd1,vb])}


(* ::Text:: *)
(*2. Compute diff[diff[form,CD],CD], introducing FRiem2[CD,...] as needed. The formula:*)
(*  \!\(\*SuperscriptBox[\(d\), \(\[Del]\)]\) \!\(\*SuperscriptBox[\(d\), \(\[Del]\)]\) v^A = \!\( *)
(*\*SubsuperscriptBox[\(F[\[Del]\(\(,\)\(VB\)\)]\), \(\(\ \ \ \)\(B\)\), \(A\)]\[Wedge]*)
(*\*SuperscriptBox[\(v\), \(B\)]\)             (where VB is the VBundle of A; plus sign for +VB, minus sign for -VB)*)


(* ::Input::Initialization:: *)
Diff[Diff[expr_,PD],PD]:=0


(* ::Input::Initialization:: *)
HoldPattern@Diff[HoldPattern[Diff[expr_,cd_]],cd_]:=
Plus@@Map[addFRiem2[expr,cd],xAct`xTensor`Private`selecton[Select[FindFreeIndices@expr,AIndexQ],VBundlesOfCovD@cd]];


(* ::Input::Initialization:: *)
addFRiem2[expr_,cd_][{oldind_?xAct`xTensor`Private`upQ,dummy_}]:=Wedge[CurvatureForm[cd,VBundleOfIndex[oldind]][oldind,-dummy],ReplaceIndex[expr,oldind->dummy]];

addFRiem2[expr_,cd_][{oldind_?xAct`xTensor`Private`downQ,dummy_}]:=-Wedge[CurvatureForm[cd,VBundleOfIndex[oldind]][dummy,oldind],ReplaceIndex[expr,oldind->-dummy]]


(* ::Text:: *)
(*Just in case, add the following definitions:*)


(* ::Input::Initialization:: *)
CurvatureForm[PD,_]:=Zero;


(* ::Input::Initialization:: *)
RiemannForm[PD]:=Zero;


(* ::Text:: *)
(*3. Change from FRiem2[CD1,VB] to FRiem2[CD2,VB],  introducing diff[AChr1[CD...]] and Wedge[AChr1,AChr1]. The formula:*)
(*  \!\( *)
(*\*SubsuperscriptBox[\(F[CD2, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)] = \( *)
(*\*SubsuperscriptBox[\(F[CD1, VB]\), \(\(\ \ \ \)\(B\)\), \(A\)]\  + \ *)
(*\*SuperscriptBox[\(d\), \(CD1\)] *)
(*\*SubsuperscriptBox[\(A[CD2, CD1, VB]\), \(\(\ \ \ \ \)\(B\)\), \(A\)] + *)
(*\*SubsuperscriptBox[\(A[CD2, CD1, VB]\), \(\(\ \ \ \ \)\(C\)\), \(A\)]\[Wedge]*)
(*\*SubsuperscriptBox[\(A[CD2, CD1, VB]\), \(\(\ \ \ \ \)\(B\)\), \(C\)]\)\)*)


(* ::Input::Initialization:: *)
ChangeCurvatureForm[expr_,cd_,cd_]:=expr;
ChangeCurvatureForm[expr_,cd1_?CurvatureQ,cd2_:PD]:=ReduceAChr1[expr/.changeCurvatureFormRules[cd1,cd2]];
ChangeCurvatureForm[expr_,list_List,cd2_:PD]:=Fold[ChangeCurvatureForm[#1,#2,cd2]&,expr,list];
ChangeCurvatureForm[expr_,_,_:PD]:=expr;
ChangeCurvatureForm[expr_]:=ChangeCurvatureForm[expr,$CovDs];


(* ::Input::Initialization:: *)
changeCurvatureFormRules[cd2_,cd1_]:={CurvatureForm[cd2,vb_?VBundleQ][a_,b_]:>
With[{c=DummyIn@vb,A1=ConnectionForm[cd2,cd1,vb]},CurvatureForm[cd1,vb][a,b]+Diff[A1[a,b],cd1]+Wedge[A1[a,-c],A1[c,b]]],RiemannForm[cd2][a_,b_]:>
With[{c=DummyIn@Tangent@ManifoldOfCovD@cd2,A1=ChristoffelForm[cd2,cd1]},RiemannForm[cd1][a,b]+Diff[A1[a,b],cd1]+Wedge[A1[a,-c],A1[c,b]]]};


(* ::Subsubsection::Closed:: *)
(*3.5 UseCartan*)


(* ::Input:: *)
(*?UseCartan*)


(* ::Input::Initialization:: *)
(* Thread over equations and lists *)
UseCartan[expr_List,covd_]:=UseCartan[#,covd]&/@expr;
UseCartan[expr_List,PD,{mani__?ManifoldQ}]:=UseCartan[#,PD,{mani}]&/@expr;
UseCartan[expr_Equal,covd_]:=UseCartan[#,covd]&/@expr;
UseCartan[expr_Equal,PD,{mani__?ManifoldQ}]:=UseCartan[#,PD,{mani}]&/@expr;


(* ::Input::Initialization:: *)
(* Exterior derivative when covd is PD *)
UseCartan[expr_,PD,{mani__?ManifoldQ}]:=(expr/.Diff@expr1_:>Module[{a=DummyIn/@(Tangent/@{mani})},Inner[dx[#1][#2]PD[-#2]@expr1&,{mani},a,Plus]]/;Deg@expr1===0);
UseCartan[expr_,PD]:=(expr/.Diff@expr1_:>Module[{a=DummyIn/@(Tangent/@ManifoldsOf@expr)},Inner[dx[#1][#2]PD[-#2]@expr1&,ManifoldsOf@expr,a,Plus]]/;Deg@expr1===0);


(* ::Text:: *)
(*We encode the Cartan equations in a set of rules. We also encode the action of the exterior derivative on a function whose arguments are scalars of a coordinate chart.*)


(* ::Input::Initialization:: *)
UseCartan[expr_,covd_]:=With[{metric=MetricOfCovD[covd],basis=BasisOfCovD[covd]},
expr/.Flatten@
(* Exterior derivative of the coframe *)
{HoldPattern[Diff[Coframe[mani_][ind_?UpIndexQ],PD]]:>Module[{a=DummyIn@VBundleOfIndex@ind},If[TorsionQ@covd,-ConnectionForm[covd,VBundleOfIndex@ind][ind,-a]\[Wedge]Coframe[mani][a]+TorsionForm[covd][ind],-ConnectionForm[covd,VBundleOfIndex@ind][ind,-a]\[Wedge]Coframe[mani][a]]],
(* Exterior derivative of the connection *)
HoldPattern[Diff[(connection:(ConnectionForm|ChristoffelForm))[covd,vbundle_:Tangent@ManifoldOfCovD@covd][a1_?UpIndexQ,-a2_],PD]]:>Module[{a=DummyIn@VBundleOfIndex@a1},CurvatureForm[covd,vbundle][a1,-a2]-connection[covd,vbundle][a1,-a]\[Wedge]connection[covd,vbundle][a,-a2]],
(* Exterior derivative of the torsion *)
HoldPattern[Diff[TorsionForm[covd][ind_?UpIndexQ],PD]]:>Module[{a=DummyIn@VBundleOfIndex@ind},Coframe[ManifoldOfCovD@covd][a]\[Wedge]RiemannForm[covd][ind,-a]-ChristoffelForm[covd][ind,-a]\[Wedge]TorsionForm[covd][a]],
(* Exterior derivative of the curvature *)
HoldPattern[Diff[(curvature:(CurvatureForm|RiemannForm))[covd,vbundle_:Tangent@ManifoldOfCovD@covd][a1_?UpIndexQ,-a2_],PD]]:>Module[{a=DummyIn@VBundleOfIndex@a1},ConnectionForm[covd,vbundle][a,-a2]\[Wedge]curvature[covd,vbundle][a1,-a]-curvature[covd,vbundle][a,-a2]\[Wedge]ConnectionForm[covd,vbundle][a1,-a]],
(* Exterior derivative of the metric (indices downstairs) *)
HoldPattern[Diff[metr_?MetricQ[-a1_,-a2_],PD]]:>Module[{a=DummyIn@VBundleOfIndex@a1},ChristoffelForm[covd][a,-a1]metric[-a,-a2]+ChristoffelForm[covd][a,-a2]metric[-a,-a1]]/;MetricOfCovD[covd]===metr,
(* Exterior derivative of the metric (indices upstairs) *)
HoldPattern[Diff[metric[a1_Symbol,a2_Symbol],PD]]:>-ChristoffelForm[covd][a1,a2]-ChristoffelForm[covd][a2,a1],
(* Exterior derivative when covd is the parallel derivative of a coordinate chart *)
HoldPattern@Diff[expr1_?ScalarQ,PD]:>Inner[covd[{#1,-BasisOfCovD@covd}]@expr1 Diff@#2&,CNumbersOf[basis,VBundleOfBasis[basis]],ScalarsOfChart[basis],Plus]/;(Deg@expr1===0&&basis=!=Null),
If[metric=!=Null,
With[{eps=epsilon[metric]},
HoldPattern[Diff[eps[inds__?DownIndexQ],PD]]:>Module[{a=DummyIn[VBundleOfMetric[metric]]},ChristoffelForm[covd][a,-a]eps[inds]]
],
{}
]
}
];


(* ::Subsubsection::Closed:: *)
(*3.6 Interior product and Lie derivative*)


(* ::Text:: *)
(*We define the interior product of form with a vector as a derivation of degree -1.*)


(* ::Input:: *)
(*?Int*)


(* ::Input::Initialization:: *)
DefGradedDerivation[Int[v_],Wedge,-1,PrintAs->"\[Iota]"];


(* ::Text:: *)
(*Main properties of the interior product:*)


(* ::Input::Initialization:: *)
Int[v_][f_ form_]:=f Int[v][form]/;Deg@f===0;
Int[v_][f_]:=0/;Deg@f===0;
Int[f_?ScalarQ v_][form_]:=f Int[v][form];
Int[v_[ind1_Symbol]][Coframe[mani_][ind2_]]:=v[ind2]/;v=!=Coframe[mani];
Int[v_[ind1_Symbol]][dx[mani_][ind2_]]:=v[ind2]/;v=!=dx[mani];
Int[v_[-ind1_Symbol]][Coframe[mani_][ind2_]]:=v[-ind1](First@MetricsOfVBundle@Tangent@mani)[ind1,ind2];
Int[v_[-ind1_Symbol]][dx[mani_][ind2_]]:=v[-ind1](First@MetricsOfVBundle@Tangent@mani)[ind1,ind2];
Int[Basis[{cnumber1_?IntegerQ,-basisname_?BasisQ},ind_Symbol]][dx[mani_][{cnumber2_?IntegerQ,basisname_?BasisQ}]]:=0/;cnumber1=!=cnumber2;
Int[Basis[{cnumber1_?IntegerQ,-basisname_?BasisQ},ind_Symbol]][dx[mani_][{cnumber2_?IntegerQ,basisname_?BasisQ}]]:=1/;cnumber1===cnumber2;
Int[Basis[{cnumber1_?IntegerQ,-basisname_?BasisQ},ind_Symbol]][Coframe[mani_][{cnumber2_?IntegerQ,basisname_?BasisQ}]]:=0/;cnumber1=!=cnumber2;
Int[Basis[{cnumber1_?IntegerQ,-basisname_?BasisQ},ind_Symbol]][Coframe[mani_][{cnumber2_?IntegerQ,basisname_?BasisQ}]]:=1/;cnumber1===cnumber2;


(* ::Text:: *)
(*Interior contraction of basis objects is zero.*)


(* ::Input::Initialization:: *)
Int[v_][_Basis]:=0;


(* ::Input:: *)
(*?CartanD*)


(* ::Input::Initialization:: *)
DefGradedDerivation[CartanD[v_],Wedge,0,PrintAs->"L"];


(* ::Text:: *)
(*Lie acting on basis objects is zero.*)


(* ::Input::Initialization:: *)
CartanD[v_][_Basis]:=0;


(* ::Input::Initialization:: *)
CartanD[v_][_Basis,_]:=0;


(* ::Text:: *)
(*Superscript formatting for Lie derivatives arising from the exterior derivatives*)


(* ::Input::Initialization:: *)
CartanD/:MakeBoxes[CartanD[v_][form_,PD?CovDQ],StandardForm]:=xAct`xTensor`Private`interpretbox[CartanD[v][form,PD],RowBox[{SubscriptBox["L",MakeBoxes[v,StandardForm]],"[",MakeBoxes[form,StandardForm],"]"}]];
CartanD/:MakeBoxes[CartanD[v_][form_,cd_?CovDQ],StandardForm]:=xAct`xTensor`Private`interpretbox[CartanD[v][form,cd],RowBox[{SubsuperscriptBox["L",MakeBoxes[v,StandardForm],Last@SymbolOfCovD[cd]],"[",MakeBoxes[form,StandardForm],"]"}]];


(* ::Input::Initialization:: *)
CartanD[f_?ScalarQ v_][form_]:=f CartanD[v]@form+Wedge[Diff@f,Int[v]@form];


(* ::Text:: *)
(*We still need definition when acting on Times*)


(* ::Input::Initialization:: *)
(* This produces expanded expressions and is much faster when there are many scalars *)
CartanD[v_][expr_Times]:=Module[{grades=Grade[#,Wedge]&/@List@@expr,pos,scalar,form},
pos=Position[grades,_?(#=!=0&),1,Heads->False];
Which[
Length[pos]>1,
	Throw[Message[Diff::error1,"Found Times product of nonscalar forms: ",expr]],
Length[pos]===1,
	pos=pos[[1,1]];
	scalar=Delete[expr,{pos}];
	form=expr[[pos]];
	scalar CartanD[v][form]+lie0[v][scalar,form],
Length[pos]===0,
	lie0[v][expr]
]
];
(* Only scalars *)
lie0[v_][expr_Times]:=Sum[MapAt[CartanD[v],expr,i],{i,1,Length[expr]}];
lie0[v_][expr_]:= CartanD[v][expr];
(* Scalars and a form *)
lie0[v_][expr_Times,form_]:=Sum[MapAt[lie0[v][#,form]&,expr,i],{i,1,Length[expr]}];
lie0[v_][expr_,form_]:=Wedge[CartanD[v][expr],form];


(* ::Input::Initialization:: *)
CartanD[v_][expr_?ConstantQ]:=0;


(* ::Text:: *)
(*Leibinitz rule for xTensor LieD when acting on wedge product expressions:*)


(* ::Input::Initialization:: *)
Unprotect@LieD;
LieD[v_]@expr_Wedge:=(CartanD[v]@expr/.CartanD->LieD);
Protect@LieD;


(* ::Text:: *)
(*Lie and diff commute (probably not true for covariant exterior derivatives). We need to pick a canonical order. Should this be done by a SortDs type function?*)


(* ::Text:: *)
(*Cartan identity:*)


(* ::Input::Initialization:: *)
CartanDToDiff[expr_]:=expr/.{CartanD[v_][form_]:>Diff@Int[v]@form+Int[v]@Diff@form,CartanD[v_][form_,covd_?CovDQ]:>Diff[Int[v]@form,covd]+Int[v]@Diff[form,covd]};


(* ::Text:: *)
(*Lie derivative of a tensor valued differential form. We overload the xTensor command LieDToCovD. Note: xTensor LieD doesn't know how to work with wedge products.*)


(* ::Input:: *)
(*?LieDToCovD*)


(* ::Input::Initialization:: *)
LieDForm[v_[ind_],covd_?CovDQ]@ten_:=Module[{a=DummyIn@VBundleOfIndex@ind},ToCanonical[LieD[v[ind],covd]@ten+CartanD[v[ind]][ten,covd]-v[a]covd[-a]@ten,UseMetricOnVBundle->None]];
LieDFormToCovD[expr_,covd_]:=expr//.LieD[vector_]:>LieDForm[vector,covd];


(* ::Input::Initialization:: *)
Unprotect@LieDToCovD;
LieDToCovD[expr_,arg_:PD]:=LieDFormToCovD[expr,arg]/;Deg@expr>=1
Protect@LieDToCovD;


(* ::Subsubsection::Closed:: *)
(*3.7 Commuting and sorting of the derivations *)


(* ::Text:: *)
(*There are 6 equations in all for the (super-)commutators of the three derivations (also the negations of these three equations). It is easy to write them down. The LHS's are just super-commutators of two derivations, in whatever order you want. The sign is + just for [odd,odd] so that's for [d,d], [\[Iota],\[Iota]], and [\[Iota],d]. Then the RHS is itself a single derivation, with the degree being the sum of degrees from the LHS. If there is only one vector argument, it's clear what the RHS should be. When there are two vector arguments, then the vector on the RHS is the Lie bracket of the two from the LHS, in the order that they came on the LHS.*)
(* *)
(*The equations are:*)
(*1. d^2=0*)
(*2. Subscript[\[Iota], v] Subscript[\[Iota], w]+Subscript[\[Iota], w] Subscript[\[Iota], v]=0*)
(*3. Subscript[\[ScriptCapitalL], v] Subscript[\[ScriptCapitalL], w]-Subscript[\[ScriptCapitalL], w] Subscript[\[ScriptCapitalL], v]=\!\(\*SubscriptBox[\(\[ScriptCapitalL]\), \(\([\)\(v, w\)\(]\)\)]\)*)
(*4. Subscript[\[Iota], v] Subscript[\[ScriptCapitalL], w]-Subscript[\[ScriptCapitalL], w] Subscript[\[Iota], v] = \!\(\*SubscriptBox[\(\[Iota]\), \(\([\)\(v, w\)\(]\)\)]\)*)
(*5. Subscript[\[Iota], v]d+d Subscript[\[Iota], v]= Subscript[\[ScriptCapitalL], v]*)
(*6. Subscript[\[ScriptCapitalL], v]d-d Subscript[\[ScriptCapitalL], v]=0 ("Cartan's magic formula")*)


(* ::Text:: *)
(*1. requires no action (it will just be automatically killed).*)
(*2, 3. Maybe have this sorted automatically? Any canonical order for v,w imposes a canonical order on the derivations.*)
(*4, 5, 6\[LongDash]write rules to go in either direction.*)


(* ::Input::Initialization:: *)
SortDerivationsRule[Diff,Diff]={};


(* ::Input::Initialization:: *)
SortDerivationsRule[Int,Int]={
HoldPattern[Int[v_]@Int[w_]@form_]:>-Int[w]@Int[v]@form/;!OrderedQ[{v,w}]
};


(* ::Input::Initialization:: *)
SortDerivationsRule[CartanD,CartanD]={
HoldPattern[CartanD[v_]@CartanD[w_]@form_]:>Module[{a=First@FindFreeIndices[v]},CartanD[w]@CartanD[v]@form+CartanD[Bracket[v,w][a]]@form]/;!OrderedQ[{v,w}],HoldPattern[CartanD[v_][CartanD[w_][form_,covd_?CovDQ],covd_?CovDQ]]:>Module[{a=First@FindFreeIndices[v]},CartanD[w][CartanD[v][form,covd],covd]+CartanD[Bracket[v,w][a]][form,covd]]/;!OrderedQ[{v,w}]
};


(* ::Text:: *)
(*Below, SortDerivationsRule[d1,d2][expr] changes instances of d2\[CenterDot]d1 into d1\[CenterDot]d2. There is no need to check orderings.*)


(* ::Input::Initialization:: *)
SortDerivationsRule[Int,CartanD]={
HoldPattern[CartanD[w_]@Int[v_]@form_]:>Module[{a=First@FindFreeIndices[w]},Int[v]@CartanD[w]@form+Int[Bracket[w,v][a]]@form],HoldPattern[CartanD[w_][Int[v_]@form_,covd_?CovDQ]]:>Module[{a=First@FindFreeIndices[w]},Int[v]@CartanD[w][form,covd]+Int[Bracket[w,v][a]]@form]
};
SortDerivationsRule[CartanD,Int]={
HoldPattern[Int[v_]@CartanD[w_]@form_]:>Module[{a=First@FindFreeIndices[w]},CartanD[w]@Int[v]@form+Int[Bracket[v,w][a]]@form],HoldPattern[Int[v_]@CartanD[w_][form_,covd_?CovDQ]]:>Module[{a=First@FindFreeIndices[w]},CartanD[w][Int[v]@form,covd]+Int[Bracket[v,w][a]]@form]
};


(* ::Input::Initialization:: *)
SortDerivationsRule[Int,Diff]={
HoldPattern[Diff[Int[v_]@form_,covd_?CovDQ]]:>-Int[v]@Diff[form,covd]+CartanD[v][form,covd]
};
SortDerivationsRule[Diff,Int]={
HoldPattern[Int[v_]@Diff[form_,covd_?CovDQ]]:>-Diff[Int[v]@form,covd]+CartanD[v][form,covd]
};


(* ::Input::Initialization:: *)
SortDerivationsRule[CartanD,Diff]={
HoldPattern[Diff[CartanD[v_]@form_,PD]]:>CartanD[v]@Diff@form,HoldPattern[Diff[CartanD[v_][form_,covd_?CovDQ],covd_?CovDQ]]:>CartanD[v][Diff[form,covd],covd]
};
SortDerivationsRule[Diff,CartanD]={
HoldPattern[CartanD[v_]@Diff[form_,PD]]:>Diff@CartanD[v]@form,HoldPattern[CartanD[v_][Diff[form_,covd_?CovDQ],covd_?CovDQ]]:>Diff[CartanD[v][form,covd],covd]
};


(* ::Text:: *)
(*Now we choose a default left-to-right order that we want derivations to have. I don't know if there is a best order (i.e. what encourages the largest number of terms to vanish).*)


(* ::Input:: *)
(*?$DerivationSortOrder*)


(* ::Input::Initialization:: *)
$Derivations={CartanD,Int,Diff};
$DerivationSortOrder=$Derivations;


(* ::Input:: *)
(*?SortDerivations*)


(* ::Input::Initialization:: *)
SortDerivations[expr_]:=SortDerivations[expr,$DerivationSortOrder]
SortDerivations[expr_,order_List]:=Module[{},

(* Make sure that order is some permutation of $Derivations *)
If[Sort@order=!=Sort@$Derivations,Throw@Message[SortDerivations::invalid,"order",order];];

expr//.Join@@Table[Join@@(SortDerivationsRule[order[[i]],#]&/@Drop[order,i]),{i,1,Length@order-1}]//.Join@@(SortDerivationsRule[#,#]&/@order)
];


(* ::Subsection::RGBColor[0, 0, 1]:: *)
(*4. Variational derivatives of top rank forms*)


(* ::Subsubsection::Closed:: *)
(*4.1 FormVarD*)


(* ::Text:: *)
(*Check that a form has top rank*)


(* ::Input::Initialization:: *)
TopRankQ[form_]:=With[{manifolds=Select[DependenciesOf@form,ManifoldQ]},
If[Length@manifolds != 1,
Throw@Message[TopRankQ::error1,"Forms must have exactly 1 manifold in dependencies."],
TopRankQ[form,First@manifolds]]];
TopRankQ[form_,mani_?ManifoldQ]:=Grade[form,Wedge]===DimOfManifold@mani;


(* ::Text:: *)
(*FormVarD is supposed to be like VarD, but for top-rank forms. A derivative is not specified, because the exterior derivative is natural. However, the adjoint to the exterior derivative, the codifferential, requires a Hodge dual, which we define via a (non-degenerate!) metric. Therefore FormVarD has the notation FormVarD[form, metric][expr, rest]. The convention is that expr and rest are combined as \[Delta](expr)\[Wedge]rest (here I write the variational derivative as \[Delta], and always subscript the codifferential as Subscript[\[Delta], g]). This means that when writing the Leibniz rule for the Wedge product, we must re-order the factors, i.e.*)
(*  \[Delta](a\[Wedge]b\[Wedge]c) = \[Delta]a\[Wedge]b\[Wedge]c + a\[Wedge]\[Delta]b\[Wedge]c + a\[Wedge]b\[Wedge]\[Delta]c=\[Delta]a\[Wedge]b\[Wedge]c + \!\(\*SuperscriptBox[\((\(-1\))\), \(\(|\)\(a || b\)\(|\)\)]\)\[Delta]b\[Wedge]a\[Wedge]c + (-1)^((|a|+|b|)|c|)\[Delta]c\[Wedge]a\[Wedge]b       etc.*)
(*The other identities we need follow. For a Hodge star,*)
(*  a\[Wedge]\!\(( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\)b) = Subscript[\[LeftAngleBracket]a,b\[RightAngleBracket], g] Subscript[dVol, g]     *)
(*where |a|+|*b|=n, and where*)
(*  Subscript[\[LeftAngleBracket]a,b\[RightAngleBracket], g] = g^(Subscript[i, 1] Subscript[j, 1])... g^(Subscript[i, k] Subscript[j, k]) Subscript[a, Subscript[i, 1]... Subscript[i, k]] Subscript[b, Subscript[j, 1]... Subscript[j, k]]*)
(*is the inner product on k-forms given by the metric g, and Subscript[dVol, g]=\[Star]1 is the metric volume element, given in a coordinate basis by*)
(*  Subscript[dVol, g]=Sqrt[|det g|](dx^1)\[Wedge]...\[Wedge]dx^n.*)
(*With a real metric and real-valued forms, it is clear that \[LeftAngleBracket]a,b\[RightAngleBracket] = \[LeftAngleBracket]b,a\[RightAngleBracket] and so*)
(*  a\[Wedge](\!\( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\(b\)\)) = b\[Wedge](\!\( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\(a\)\))        (for |a|+|*b|=n) *)
(*or in the way we'll use it,*)
(*  (\!\( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\(a\)\))\[Wedge]b = \!\(\*SuperscriptBox[\((\(-1\))\), \(\(|\)\(a\)\(|\)\((\(\(n\)\(-\)\) | a | )\)\)]\) a\[Wedge](\!\( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\(b\)\))      (for |a|+|*b|=n) *)
(*QUESTION: What about \[DoubleStruckCapitalC]-valued forms?*)
(*We also have that diff and codiff (of any CovD) are adjoints of each other, in the sense that*)
(*  \[Integral]  \!\(\(\(da\)\(\[Wedge]\)\)*)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\)b = \[Integral]  \!\(\(\(b\)\(\[Wedge]\)\)*)
(*\*SubscriptBox[\(\[Star]\), \(g\)]da\) = \[Integral]  \!\(\(\(a\)\(\[Wedge]\)\)*)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\( *)
(*\*SubscriptBox[\(\[Delta]\), \(g\)] b\)\) = \[Integral]  \!\(\( *)
(*\*SubscriptBox[\(\[Delta]\), \(g\)] \(\(b\)\(\[Wedge]\)\)\)*)
(*\*SubscriptBox[\(\[Star]\), \(g\)]a\)*)
(*The above rule is convenient with the inverse of Hodge, i.e. \!\( *)
(*\*SubsuperscriptBox[\(\[Star]\), \(g\), \(-1\)]*)
(*\*SubscriptBox[\(\[Star]\), \(g\)]\)=\!\( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]*)
(*\*SubsuperscriptBox[\(\[Star]\), \(g\), \(-1\)]\)=id. This inverse is*)
(*  \!\( *)
(*\*SubsuperscriptBox[\(\[Star]\), \(g\), \(-1\)]\(a\)\)=\!\(\( *)
(*\*SuperscriptBox[\((\(-1\))\), \(\(|\)\(a\)\(|\)\((\(\(n\)\(-\)\) | a | )\)\)] s\)\ *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]a\)*)
(*where s=SignDetOfMetric[g]*)
(*TODO:*)
(*  1. Act on Subscript[\[Star], g2] and Subscript[\[Delta], g2] where g2 is a second metric on the same manifold, and is also non-degenerate. Subscript[\[Star], g2] can be converted to Subscript[\[Star], g] by including a ratio of volume elements (the ratio is coordinate-free).*)
(*  2. What to do with Lie, Int?*)
(*  3. What about coframe, connection, torsion, curvature, etc.?*)


(* ::Input::Initialization:: *)
InvHodge[metric_][expr_]:=With[{k=Grade[expr,Wedge],n=DimOfMetric@metric,s=SignDetOfMetric@metric},
(-1)^(k(n-k))s Hodge[metric]@expr];


(* ::Text:: *)
(*We will use it as follows:*)
(*  \[Integral] da \[Wedge] c = \[Integral] a \[Wedge] \!\( *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]*)
(*\*SubscriptBox[\(\[Delta]\), \(g\)]*)
(*\*SubsuperscriptBox[\(\[Star]\), \(g\), \(-1\)]\(c\)\)*)
(*and*)
(*  \[Integral] Subscript[\[Delta], g]b \[Wedge] c = \[Integral] \!\(\(\(b\)\(\ \)\(\[Wedge]\)\)\ *)
(*\*SubscriptBox[\(\[Star]\), \(g\)]d*)
(*\*SubsuperscriptBox[\(\[Star]\), \(g\), \(-1\)]c\)*)


(* ::Input::Initialization:: *)
(* TODO:More checks that form is actually on same manifold as metric, etc. *)
(* Generate rest. Replace dummies in expr. This does not act on scalar arguments of functions *)
FormVarD[form_,met_][expr_]:=If[TopRankQ[expr]&&ScalarQ[expr],
FormVarD[form,met][ReplaceDummies@expr,1],
Throw@Message[General::error1,"Can only take variational derivative of top-rank form."]];
(* Thread over Plus *)
FormVarD[form_,met_][expr_Plus,rest_]:=FormVarD[form,met][#,rest]&/@expr;
FormVarD[form_,met_][expr_SeriesData,rest_]:=xAct`xTensor`Private`SeriesDataMap[FormVarD[form,met][#,rest]&,expr];
(* FormVarD on products: sum of VarDtake's of elements *)
FormVarD[form_,met_][expr_Times,rest_]:=With[{grades=Grade[#,Wedge]&/@List@@expr},
If[Length@Position[grades,_?(#=!=0&),1,Heads->False]>1,
Throw[Message[FormVarD::error1,"Found Times product of nonscalar forms: ",expr]]];	Sum[FormVarDtake[form,met,rest,List@@expr,count],{count,Length@expr}]
];
(* FormVarD on wedges: sum of FormVarDtake's of elements.
Note the use of sumgrades for reordering the Wedge, as described above. *)
FormVarD[form_,met_][expr_Wedge,rest_]:=With[{grades=Grade[#,Wedge]&/@List@@expr},
With[{sumgrades=FoldList[Plus,0,grades]},
Sum[(-1)^(grades[[count]]* sumgrades[[count]])FormVarDtake[form,met,rest,List@@expr,count],{count,Length@expr}]]];
(* FormVarD element n of a list of Wedge factors (no sign--it was included above) *)
FormVarDtake[form_,met_,rest_,list_List,n_Integer]:=FormVarD[form,met][list[[n]],Wedge[Wedge@@Drop[list,{n}],rest]];
(* Scalar functions. Multiargument generalization contributed by Leo. multiD is not enough here.
 Since operating on a scalar function, don't need extra Wedge's *)
FormVarD[form_,met_][func_?ScalarFunctionQ[args__],rest_]:=With[{repargs=ReplaceDummies/@{args}},Plus@@MapThread[FormVarD[form,met][#1,rest (Derivative@@#2)@func@@repargs]&,{repargs,IdentityMatrix@Length@repargs}]];
(* Remove Scalar head because in general the result is not a scalar *)
FormVarD[form_,met_][Scalar[expr_],rest_]:=FormVarD[form,met][ReplaceDummies[expr],rest];
(* Constants *)
FormVarD[_,_][x_?ConstantQ,_]:=0;
(* Same tensor: metric. Do not use ContractMetric, which hides the metric.
Note: This part is identical to the code in VarD, since it's only metric being Wedged with rest. *)
FormVarD[metric_[a_,b_],met_][metric_Symbol?MetricQ[c_,d_],rest_]:=xAct`xTensor`Private`metricsign[a,b,c,d]ToCanonical[rest (metric[ChangeIndex@a,c]metric[ChangeIndex@b,d]+metric[ChangeIndex@a,d]metric[ChangeIndex@b,c])/2,UseMetricOnVBundle->None];
(* Same tensor. Place indices in proper delta positions. QUESTION: could this be problematic for spinors?
Note: This part is identical to the code in VarD, since it's only deltas being Wedged with rest. *)
FormVarD[form_[inds1___],met_][form_?xTensorQ[inds2___],rest_]:=With[{clist=ChangeIndex/@IndexList[inds1]},
ToCanonical[ImposeSymmetry[Inner[xAct`xTensor`Private`varddelta,clist,IndexList[inds2],Times],clist,SymmetryGroupOfTensor[form[inds1]]]rest,UseMetricOnVBundle->None]];
(* A different tensor *)
FormVarD[form1_[inds1___],met_][form2_?xTensorQ[inds2___],rest_]:=0/;!ImplicitTensorDepQ[form2,form1];
(* Hodge identity *)
FormVarD[form_,met_][Hodge[met_][expr_],rest_]:=With[{k=Grade[expr,Wedge],n=DimOfMetric@met},
(-1)^(k(n-k))FormVarD[form,met][expr,Hodge[met]@rest]];
(* diff \[Rule] Replaced by Diff to adjust to the new notation. Dropped cd. Added back PD. *)
FormVarD[form_,met_][Diff[expr_,PD],rest_]:=-FormVarD[form,met][expr,Hodge[met]@Codiff[met][InvHodge[met]@rest]];
(* codiff \[Rule] Replaced by Codiff to adjust to the new notation. Dropped cd and replaced ExtCovDiff by Diff . Added back covd *)
FormVarD[form_,met_][Codiff[met_][expr_,covd_?CovDQ],rest_]:=-FormVarD[form,met][expr,Hodge[met]@Diff[InvHodge[met]@rest,covd]];


(* ::Subsection::RGBColor[0, 0, 1]:: *)
(*5. End private and package*)


(* ::Input::Initialization:: *)
End[];
EndPackage[];
