/* eslint-disable @typescript-eslint/no-explicit-any */
import { clsx } from "clsx";
import React from "react";

interface props {
  Icon: any;
  isActive: boolean;
  className?: string;
  size?: number;
  strokeWidth?: number;
}

const IconButton: React.FC<props> = React.memo(
  ({ Icon, isActive, className, size, strokeWidth }) => {
    return (
      <>
        <button
          className={clsx(
            "bg-gradient-to-r from-[#3c3d46] to-[#3c3d46] py-2 px-4 border-[2px] border-[#6c6d75] rounded-sm",
            className
          )}
        >
          <div
            className="relative bottom-[5px] right-3 w-2 h-2 rounded-sm blur-[1px]"
            style={{
              backgroundColor: isActive
                ? "rgb(57 234 73 / 1)"
                : "rgb(225 29 72 / 1)",
            }}
          ></div>
          <Icon
            className="relative bottom-[3px]"
            size={!size ? 18 : size}
            strokeWidth={!strokeWidth ? 3 : strokeWidth}
          />
        </button>
      </>
    );
  }
);

export default IconButton;
