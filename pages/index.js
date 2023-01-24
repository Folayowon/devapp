import React, { useState, useEffect, useContext } from "react";
import { AiFillCaretRight } from "react-icons/ai";
import Image from "next/image";
import Countdown from "react-countdown";

//INTERNAL IMPORT
import { VotingContext } from "../context/Voter";
import Style from "../styles/index.module.css";
import Card from "../components/card/card";
import image from "../candidate.png";
import background from "../blockchain.svg";

const index = () => {
  const {
    getNewCandidate,
    candidateArray,
    giveVote,
    checkIfWalletIsConnected,
    candidateLength,
    getAllVoterData,
    currentAccount,
    voterLength,
  } = useContext(VotingContext);

  useEffect(() => {
    // getNewCandidate();
    // console.log(candidateArray);/
    checkIfWalletIsConnected();
  }, []);

  return (
    <div className={Style.home}>
      {currentAccount && (
        <div className={Style.container}>
          <span className={Style.img}>
            <Image src={background} />
          </span>
          <div className={Style.homeContainer}>
            <p className={Style.container_title}>Be a part of Decision</p>
            <div className={Style.home_vote}>
              <span>Vote </span>
              <span className={Style.voteColor}>Today</span>
              <span className={Style.border}></span>
            </div>
            <div className={Style.voting}>
              An online voting that will replace the centralized voting system
            </div>
            <div className={Style.accredited_voter}>
              <AiFillCaretRight className={Style.icon} />
              <div className={Style.accredited}>Get accredited to vote</div>
            </div>
            <div className={Style.btnContainer}>
              <button className={Style.btn}>Register</button>
            </div>
          </div>
        </div>
      )}
      {/* {currentAccount && (
        <div className={Style.winner}>
          <div className={Style.winner_info}>
            <div className={Style.candidate_list}>
              <p>
                No Candidate:<span>{candidateLength}</span>
              </p>
            </div>
            <div className={Style.candidate_list}>
              <p>
                No Voter:<span>{voterLength}</span>
              </p>
            </div>
          </div>
          <div className={Style.winner_message}>
            <small>
              <Countdown date={Date.now() + 10000} />
            </small>
          </div>
        </div>
      )} */}

      <Card candidateArray={candidateArray} giveVote={giveVote} />
    </div>
  );
};

export default index;