import React, { useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import "./Core.css";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const Core: React.FC = () => {
  const [visible, setVisible] = useState(false);

  useNuiEvent<boolean>("setVisible", setVisible);

  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        if (!isEnvBrowser()) fetchNui("hideFrame");
        else setVisible(!visible);
      }
    };

    window.addEventListener("keydown", keyHandler);

    return () => window.removeEventListener("keydown", keyHandler);
  }, [visible]);

  return (
    <div className="flex w-[100dvw] h-[100dvh] justify-center items-end">
      {/* <div className="mb-10 grid grid-cols-3 gap-5 max-w-[35dvw]">
        <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-[10dvw] h-[17dvh] rounded-[2px]">
          t
        </div>
        <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-[10dvw] h-[17dvh] rounded-[2px]">
          t
        </div>
        <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-[10dvw] h-[17dvh] rounded-[2px]">
          t
        </div>
        <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] h-[7dvh] col-span-3 rounded-[2px]">
          t
        </div>
      </div> */}
      <div className="flex flex-col gap-2 mb-10 justify-center items-center">
        <div className="flex gap-4 text-white">
          <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-[10dvw] h-[17dvh] rounded-[2px]">
            <div className="flex flex-col justify-center items-center font-main">
              <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                Windows
              </p>
            </div>
          </div>
          <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-[10dvw] h-[17dvh] rounded-[2px]">
            <div className="flex flex-col justify-center items-center font-main">
              <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                Seats
              </p>
            </div>
          </div>
          <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-[10dvw] h-[17dvh] rounded-[2px]">
            <div className="flex flex-col justify-center items-center font-main">
              <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                Doors
              </p>
            </div>
          </div>
        </div>
        <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-full h-[9dvh] col-span-3 rounded-[2px]">
          <div className="flex flex-col justify-center items-center font-main">
            <p className="bg-gradient-to-r px-10 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
              Miscellaneous
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Core;
