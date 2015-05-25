****   CONTROL
* Generador de gráficos.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Control MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Control=col(source(s), name("Control"))
  DATA: id=col(source(s), name("$CASENUM"), unit.category())
  GUIDE: axis(dim(2), label("Control"))
  ELEMENT: schema(position(bin.quantile.letter(1*Control)), label(id))
END GPL.

* Generador de gráficos.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Control MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Control=col(source(s), name("Control"))
  GUIDE: axis(dim(1), label("Control"))
  GUIDE: axis(dim(2), label("Frecuencia"))
  ELEMENT: interval(position(summary.count(bin.rect(Control))), shape.interior(shape.square))
END GPL.

**** TRATAMIENTO
DATASET ACTIVATE Conjunto_de_datos3.
* Generador de gráficos.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Tratamiento MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Tratamiento=col(source(s), name("Tratamiento"))
  GUIDE: axis(dim(1), label("Tratamiento"))
  GUIDE: axis(dim(2), label("Frecuencia"))
  ELEMENT: interval(position(summary.count(bin.rect(Tratamiento))), shape.interior(shape.square))
END GPL.

* Generador de gráficos.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Tratamiento MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Tratamiento=col(source(s), name("Tratamiento"))
  DATA: id=col(source(s), name("$CASENUM"), unit.category())
  GUIDE: axis(dim(2), label("Tratamiento"))
  ELEMENT: schema(position(bin.quantile.letter(1*Tratamiento)), label(id))
END GPL.


