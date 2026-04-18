import { createPortal } from 'react-dom';
import { type ReactNode, type RefObject, useLayoutEffect, useState } from 'react';
import './ShopScrollPortal.scss';

interface ShopScrollPortalProps {
  children: ReactNode;
  anchorRef: RefObject<HTMLInputElement | null>;
}

const ShopScrollPortal = ({children, anchorRef}: ShopScrollPortalProps) => {
  const [position, setPosition] = useState({top: 0, left: 0, width: 0});

  useLayoutEffect(() => {
    if (!anchorRef.current) return;

    let rafId: number;

    const updatePosition = () => {
      const rect = anchorRef.current!.getBoundingClientRect();

      setPosition({
        top: rect.bottom,
        left: rect.left,
        width: rect.width,
      });

      rafId = requestAnimationFrame(updatePosition);
    };

    updatePosition();

    window.addEventListener('scroll', updatePosition, true);
    window.addEventListener('resize', updatePosition);

    return () => {
      cancelAnimationFrame(rafId);
      window.removeEventListener('scroll', updatePosition, true);
      window.removeEventListener('resize', updatePosition);
    };
  }, [anchorRef]);

  const width = Math.min(position.width, window.innerWidth - 20);
  const left = Math.max(10, Math.min(position.left, window.innerWidth - width - 10));


  return createPortal(
    <div
      className={ 'shop-scroll-portal' }
      style={ {
        position: 'fixed',
        top: position.top,
        left: left,
        width: width,
        maxHeight: 240,
        overflowY: 'auto',
        overflowX: 'hidden',
        zIndex: 9999,
      } }
    >
      { children }
    </div>,
    document.body
  );
};

export default ShopScrollPortal;
