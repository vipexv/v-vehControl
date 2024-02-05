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
import { Info } from "lucide-react";
import { ResourceConfig } from "../types/ResourceConfig";

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
  const [resourceConfig, setResourceConfig] = useState<
    ResourceConfig | undefined
  >(undefined);

  useNuiEvent("nui:state:vehdata", setVehicleData);
  useNuiEvent("nui:state:config", setResourceConfig);

  useNuiEvent<boolean>("setVisible", setVisible);

  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (
        [
          "Escape",
          `Key${
            resourceConfig?.Keybind?.enabled
              ? resourceConfig.Keybind.key.toUpperCase()
              : "nil"
          }`,
        ].includes(e.code)
      ) {
        if (!isEnvBrowser()) {
          fetchNui("hideFrame");
          setFocusMode(false);
        } else setVisible(!visible);
      }
    };

    // const handleContextMenu = (e: MouseEvent) => {
    //   e.preventDefault(); // Prevent default right-click behavior
    //   console.log("Entered right click mode");
    // };

    const handleMouseDown = (e: MouseEvent) => {
      if (e.button === 2) {
        e.preventDefault();
        fetchNui("vehmenu:togglefocus", false);
        setFocusMode(true);
      }
    };

    const handleMouseUp = (e: MouseEvent) => {
      if (e.button === 2) {
        e.preventDefault();
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
      mounted={visible && !focusMode}
      duration={400}
      transition={"pop"}
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
                "flex flex-col gap-2 mb-10 justify-center items-center transition-all"
              )}
            >
              <div className="flex items-end gap-4 text-white">
                <div className="flex flex-col justify-end gap-1">
                  {/* <div className="bg-gradient-to-r font-main from-[#222530] to-[#1d212b] h-fit  px-4 py-1 rounded-[2px]">

                  </div> */}
                  {vehicleData?.seats && vehicleData.seats <= 4 && (
                    <>
                      <p className="font-main flex items-center bg-gradient-to-r p-2 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold text-sm">
                        <Info size={20} strokeWidth={2.25} className="mr-2" />{" "}
                        <span className="mt-1">
                          Tip: Right click to enter focus mode.
                        </span>
                      </p>
                    </>
                  )}
                  <div className="flex items-end gap-4">
                    <Windows vehicleData={vehicleData} />
                    <Seats vehicleData={vehicleData} />
                  </div>
                </div>
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
