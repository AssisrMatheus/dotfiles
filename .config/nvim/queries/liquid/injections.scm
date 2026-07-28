; extends

; The upstream tree-sitter-liquid injection query highlights CSS inside `<style>`
; tags (via the html injection) and `{% style %}` blocks, but not Shopify's
; `{% stylesheet %}...{% endstylesheet %}` tag. Inject CSS there too.
(stylesheet_statement
  (stylesheet_content) @injection.content
  (#set! injection.language "css")
  (#set! injection.combined))
