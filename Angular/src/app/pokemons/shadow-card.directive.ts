import { Directive, ElementRef, HostListener, Renderer2 } from '@angular/core';

@Directive({
  selector: '[appPkmnShadowCard]'
})
export class ShadowCardDirective {
  constructor(public elem: ElementRef, public renderer: Renderer2) {
    this.setBorder('#f5f5f5');
    this.setHeight('180px');
  }

  @HostListener('mouseenter') onMouseEnter() {
    this.setBorder('#009688');
  }

  @HostListener('mouseleave') onMouseLeave() {
    this.setBorder('#f5f5f5');
  }

  private setBorder(color: string) {
    const style = `solid 4px ${color}`;
    this.renderer.setStyle(this.elem.nativeElement, 'border', style);
  }

  private setHeight(height: string) {
    this.renderer.setStyle(this.elem.nativeElement, 'height', height);
  }
}
