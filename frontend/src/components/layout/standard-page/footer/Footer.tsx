import './Footer.scss';
import type { ReactNode } from 'react';

interface FooterProps {
  children: ReactNode;
}

const Footer = ({children}: FooterProps) => {
  return (
    <div className="standard-footer py-4 border-t border-gray-200 bg-white flex items-center justify-end gap-3">
      { children }
    </div>
  );
};

export default Footer;