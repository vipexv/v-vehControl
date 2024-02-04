import { Transition } from "@mantine/core";
import clsx from "clsx";
import React, { useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { VehicleData } from "../types/VehicleData";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import "./Core.css";
import Doors from "./Main/Doors";
import MiscellaneousActions from "./Main/MiscellaneousActions";
import Seats from "./Main/Seats";
import Windows from "./Main/Windows";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const Core: React.FC = () => {
  const [visible, setVisible] = useState(false);
  const [vehicleData, setVehicleData] = useState<VehicleData | undefined>(
    undefined
  );

  const [focusMode, setFocusMode] = useState(false);

  useNuiEvent("nui:state:vehdata", setVehicleData);

  useNuiEvent<boolean>("setVisible", setVisible);

  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        if (!isEnvBrowser()) fetchNui("hideFrame");
        else setVisible(!visible);
      }
    };

    // const handleContextMenu = (e: MouseEvent) => {
    //   e.preventDefault(); // Prevent default right-click behavior
    //   console.log("Entered right click mode");
    // };

    const handleMouseDown = (e: MouseEvent) => {
      if (e.button === 2) {
        fetchNui("vehmenu:togglefocus", false);
        setFocusMode(true);
      }
    };

    const handleMouseUp = (e: MouseEvent) => {
      if (e.button === 2) {
        fetchNui("vehmenu:togglefocus", true);
        setFocusMode(false);
      }
    };

    window.addEventListener("keydown", keyHandler);

    window.addEventListener("mousedown", handleMouseDown);
    window.addEventListener("mouseup", handleMouseUp);

    return () => {
      window.removeEventListener("keydown", keyHandler);
      window.removeEventListener("mousedown", handleMouseDown);
      window.removeEventListener("mouseup", handleMouseUp);
    };
  }, [visible]);

  return (
    <Transition
      mounted={visible}
      duration={400}
      transition={"slide-up"}
      timingFunction="ease"
    >
      {(styles) => (
        <>
          <div
            style={styles}
            className="flex w-[100dvw] h-[100dvh] justify-center items-end"
          >
            <div
              className={clsx(
                "flex flex-col gap-2 mb-10 justify-center items-center transition-all",
                focusMode && "-mb-[60dvh]"
              )}
            >
              <div className="flex items-end gap-4 text-white">
                <Windows vehicleData={vehicleData} />
                <Seats vehicleData={vehicleData} />
                <Doors vehicleData={vehicleData} />
              </div>
              <MiscellaneousActions vehicleData={vehicleData} />
            </div>
          </div>
        </>
      )}
    </Transition>
  );
};

export default Core;
