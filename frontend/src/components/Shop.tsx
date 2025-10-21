import { useEffect, useState } from 'react';

export default function Shop() {

  useEffect(() => {
    console.log('shop works')
  }, []);

  return (
    <div>This is a shop</div>
  );
}
