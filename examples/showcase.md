# Introducción

Este documento existe para una sola cosa: mostrar, en una sola pasada, todo lo que **md2pdf** sabe convertir. Está pensado como material de referencia — generalo con distintas combinaciones de flags (`--toc`, `--kindle`, `--sans`, etc.) y compará el resultado.

> [!NOTE]
> Este es un callout de tipo **NOTE**. Se usa para agregar información adicional relevante que no interrumpe el flujo de lectura principal.

## Callouts estilo GitHub

md2pdf reconoce los cinco tipos de callout que soporta GitHub-flavored Markdown, cada uno con su propio color de acento:

> [!TIP]
> Este es un **TIP**: un consejo práctico que ayuda a hacer algo mejor o más rápido.

> [!IMPORTANT]
> Este es un **IMPORTANT**: información que el lector no debería pasar por alto aunque esté leyendo rápido.

> [!WARNING]
> Este es un **WARNING**: advierte sobre algo que puede causar problemas si se ignora.

> [!CAUTION]
> Este es un **CAUTION**: el nivel más alto de alerta, reservado para riesgo de daño o pérdida de datos.

## Texto y énfasis

Markdown estándar de siempre: **negrita**, *cursiva*, ***negrita y cursiva***, `código inline`, ~~tachado~~ y enlaces como [el repo de Pandoc](https://pandoc.org/).

También se pueden agregar notas al pie[^1] para referencias o aclaraciones que no conviene meter en el cuerpo del texto[^2].

[^1]: Esta es la primera nota al pie, se renderiza al final de la página o del documento según el motor.
[^2]: Y esta es la segunda, para mostrar que pueden ser varias sin pisarse.

## Listas

Lista simple:

- Pandoc parsea el Markdown
- Typst tipografía y genera el PDF
- No hace falta ni LaTeX ni Chromium

Lista anidada con varios niveles:

1. Instalación
   1. Opción nativa (pandoc + typst en el `PATH`)
   2. Opción Docker (solo necesita Docker Desktop)
2. Uso
   - Documento simple
   - Con portada y tabla de contenidos
   - Modo `--kindle` para e-readers
3. Personalización
   - Fuentes con lista de fallback
   - Colores de callouts
   - Márgenes y tamaño de papel

## Tablas

| Flag             | Qué hace                                      | Valor por defecto |
|------------------|------------------------------------------------|--------------------|
| `--toc`          | Agrega tabla de contenidos                     | desactivado        |
| `--kindle`       | Optimiza el PDF para pantalla de e-reader      | desactivado        |
| `--paper`        | Tamaño de página (`a4` o `letter`)             | `a4`               |
| `--sans`         | Cuerpo en tipografía sans en vez de serif      | serif              |
| `--base-size`    | Tamaño de fuente base en puntos                | 11 (10 en kindle)  |

\newpage

## Bloques de código con resaltado de sintaxis

Cada bloque se resalta según el lenguaje declarado después de los tres backticks.

Python:

```python
def fibonacci(n: int) -> int:
    """Devuelve el n-ésimo número de Fibonacci."""
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a
```

JavaScript:

```javascript
const toSlug = (title) =>
  title
    .toLowerCase()
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");
```

Bash:

```bash
md2pdf informe.md --title "Informe Q3" --toc --author "Daniel"
```

YAML:

```yaml
servicio: md2pdf
motor:
  parser: pandoc
  tipografia: typst
opciones:
  - toc
  - kindle
```

## Saltos de página explícitos

El párrafo que sigue a esta sección arranca en una página nueva porque el documento fuente incluye un `\newpage` justo antes del encabezado "Cierre". También existe la variante `<!-- pagebreak -->`, equivalente pero con sintaxis de comentario HTML.

\newpage

## Cierre

Con esto quedan cubiertas las piezas principales que md2pdf entiende de Markdown: callouts, tablas, código con resaltado, notas al pie, listas anidadas, énfasis de texto y saltos de página manuales — todo compilado a un PDF con tipografía cuidada, sin depender de LaTeX ni de un navegador headless.
