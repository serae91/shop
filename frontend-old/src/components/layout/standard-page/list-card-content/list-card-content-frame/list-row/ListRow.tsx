import React from 'react';

interface ListRowProps {
  label: string;
  explanation?: string;
  children: ReactNode;
  required?: boolean;
}

const ListRow = ({label, explanation, children, required = false}: ListRowProps) => {
  return (
    <div className="flex flex-col sm:flex-row sm:items-start gap-4 sm:gap-8 py-5 border-b border-gray-200">
      <div className="sm:w-64 flex-shrink-0">
        <label className="text-sm font-medium text-gray-700 flex items-center gap-1">
          { label } { required && <span className="text-brand-500">*</span> }
        </label>
        { explanation && <p className="text-sm text-gray-600 mt-1">
          { explanation }
        </p> }
      </div>
      <div className="flex-1">
        { children }
      </div>
    </div>
  );
};

export default ListRow;